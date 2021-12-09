import Foundation

/// Cache used to speed up network requests when fetching user reviews data
enum Cache {
    
    enum Key: String {
        case reviews
    }
    
    static func remove(forKey key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func put(reviews: [Review]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(reviews)
            UserDefaults.standard.set(data, forKey: Key.reviews.rawValue)
        } catch(let error) {
            assertionFailure("Error Encoding Reviews: \(error)")
        }
    }
    
    static func getReviews() -> [Review]? {
        let decoder = JSONDecoder()
        
        guard let data = UserDefaults.standard.data(forKey: Key.reviews.rawValue) else {
            return nil
        }
        do {
            let reviews = try decoder.decode(Array<Review>.self, from: data)
            return reviews
        } catch(let error) {
            assertionFailure("Error decoding Reviews: \(error)")
            return nil
        }
    }
    
    
}
