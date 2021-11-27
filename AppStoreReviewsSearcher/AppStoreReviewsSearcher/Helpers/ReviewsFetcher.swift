import UIKit

struct ReviewsFetcher {
    
    private let dateFormatter = ISO8601DateFormatter()
    enum NetworkingError: Error {
        case badResponse
    }

    enum ParsingError: Error {
        case incorrectParsing
        case ratingParsingError
        case versionParsingError
        case titleParsingError
        case contentParsingError
        case nextURLParsingError
        case dateParsingError
    }
    
    /// Gets the most recent 500 app store reviews for an app
    /// - Returns: List of reviews  capped at a count of 500
    func fetchAllReviews() async throws -> [Review] {
        if let cachedReviews = Cache.getReviews() {
            return cachedReviews
        }
        var allReviews: [Review] = []
        // We perform this due to pagination
        var url = URL.fetchAppStoreURL
        while let (reviews, nextURL) = try await fetchReviews(with: url) {
            allReviews.append(contentsOf: reviews)
            guard let newURL = nextURL, newURL != url else { break }
            url = newURL
        }
        Cache.put(reviews: allReviews)
        return allReviews
    }
    
    /// Fetches 50 reviews given the proper URL
    /// - Parameter url: URL to perform the GET request
    /// - Throws: Throws a `ParsingError` or a `NetworkingError`
    /// - Returns: A tuple containing a list of reviews (sorted by most recent reviewss), and a string containing the next URL
    private func fetchReviews(with url: URL) async throws -> ([Review], URL?)?  {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw NetworkingError.badResponse }
        let reviews = try parse(data)
        let nextURLStr = try parseNextURL(data: data)
        var nextURL: URL?
        if let nextURLStr = nextURLStr {
            // Remove the query parameters cause the next url gives some weird query params
            let jsonURL = String(nextURLStr.replacingOccurrences(of: "xml", with: "json"))
            var urlComponents = URLComponents(string: jsonURL)
            urlComponents?.queryItems = nil
            nextURL = urlComponents?.url
        }
        return (reviews, nextURL)
    }

    /// Parses the data objects into a list of review
    /// - Parameter data: The data returned from the server
    /// - Throws: Throws a `ParsingError` or a `NetworkingError`
    /// - Returns: A list of reviews
    private func parse(_ data: Data) throws -> [Review] {
        guard let rootJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
              let feed = rootJSON["feed"] as? [String: Any],
              let entry = feed["entry"] as? [[String: Any]]
        else { throw ParsingError.incorrectParsing }
        
        let reviews = try entry.map({ reviewJSON in
            return try parse(reviewJSON: reviewJSON)
        })
        return reviews
    }

    /// Parses the a single instance of a review from the proper JSON object
    /// - Parameter reviewJSON: The JSON object representing a single instance of a review
    /// - Throws: Throws a `ParsingError` or a `NetworkingError`
    /// - Returns: A single instance of a reivew
    private func parse(reviewJSON: [String : Any]) throws -> Review {
        guard let ratingJSON = reviewJSON["im:rating"] as? [String : Any],
              let ratingStr = ratingJSON["label"] as? String,
              let rating = Int(ratingStr)
        else { throw ParsingError.ratingParsingError }
        
        guard let versionJSON = reviewJSON["im:version"] as? [String : Any],
              let version = versionJSON["label"] as? String
        else { throw ParsingError.versionParsingError }
        
        guard let titleJSON = reviewJSON["title"] as? [String : Any],
              let title = titleJSON["label"] as? String
        else { throw ParsingError.titleParsingError }
        
        guard let contentJSON = reviewJSON["content"] as? [String : Any],
              let content = contentJSON["label"] as? String
        else { throw ParsingError.contentParsingError }
        
        guard let dateJSON = reviewJSON["updated"] as? [String: Any],
              let dateString = dateJSON["label"] as? String,
              let date = dateFormatter.date(from: dateString)
        else { throw ParsingError.dateParsingError }
        
        return Review(rating: rating, title: title, version: version, content: content, date: date)
    }

    /// Each call to get a list of reviews has a field in the JSON for fetching the next respective 50 reviews. This function parses the JSON to fetch that URL.
    /// - Parameter data: The data returned from the server
    /// - Throws: Throws a `ParsingError` or a `NetworkingError`
    /// - Returns: the next URL for fetch the next 50 reviews for an app
    private func parseNextURL(data: Data) throws -> String? {
        var nextLinkURL: String?
        guard let rootJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
              let feed = rootJSON["feed"] as? [String: Any]
        else { throw ParsingError.incorrectParsing }
        if let linkJSON = feed["link"] as? [[String : Any]] {
            for json in linkJSON {
                if let attributes = json["attributes"] as? [String: Any],
                   let relation = attributes["rel"] as? String, relation == "next",
                   let nextLink = attributes["href"] as? String
                {
                    nextLinkURL = nextLink
                }
            }
        }
        return nextLinkURL
    }
    
}
