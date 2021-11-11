import UIKit

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
}


struct ReviewManager {
    
    var reviews: [Review]
    
}
struct Review: Codable {
    
    var rating: Int
    var title: String
    var version: String
    var content: String
}

func fetchReviewsV2(with url: String) async throws -> ([Review], String?)?  {
    let url = URL(string: url)!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else { throw NetworkingError.badResponse }
    let reviews = try parse(data)
    var nextURL = try parseNextURL(data: data)
    if let nextURLStr = nextURL {
        // Remove the query parameters cause the next url gives some weird query params
        let jsonURL = String(nextURLStr.replacingOccurrences(of: "xml", with: "json"))
        var urlComponents = URLComponents(string: jsonURL)
        urlComponents?.queryItems = nil
        nextURL = urlComponents?.url?.absoluteString
        
    }
    print("🔵 Next URL: \(nextURL ?? "NO URL")")
    return (reviews, nextURL)
}

// V1 - Simple version
func fetchReviews() async throws -> [Review] {
    let url = URL(string: "https://itunes.apple.com/us/rss/customerreviews/id=398349296/sortby=mostrecent/json")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else { throw NetworkingError.badResponse }
    let nextURL = try parseNextURL(data: data)
    print("🔵 Next URL: \(nextURL ?? "NO URL")")
    return try parse(data)
}

func parse(_ data: Data) throws -> [Review] {
    
    guard let rootJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
          let feed = rootJSON["feed"] as? [String: Any],
          let entry = feed["entry"] as? [[String: Any]]
    else { throw ParsingError.incorrectParsing }
    
    let reviews = try entry.map({ reviewJSON in
        return try parse(reviewJSON: reviewJSON)
    })
    return reviews
}

func parse(reviewJSON: [String : Any]) throws -> Review {
//    print(reviewJSON)
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
    
    guard let contentJSON = reviewJSON["title"] as? [String : Any],
          let content = contentJSON["label"] as? String
    else { throw ParsingError.contentParsingError }
    
    return Review(rating: rating, title: title, version: version, content: content)
}

func parseNextURL(data: Data) throws -> String? {
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

Task {
    do {
        var allReviews: [Review] = []
        // We perform this due to pagination
        var url = "https://itunes.apple.com/us/rss/customerreviews/id=398349296/sortby=mostrecent/json"
        while let (reviews, nextURL) = try await fetchReviewsV2(with: url) {
            allReviews.append(contentsOf: reviews)
            guard let newURL = nextURL, newURL != url else { break }
            url = newURL
            
        }
        print(allReviews.count)
    } catch(let error) {
        print(error)
    }
    
}
print("Hello, do some work") // This is called first! since Task is asynchronous
