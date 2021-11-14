/// Represents a users review of an app
struct Review: Codable {
    var rating: Int
    var title: String
    var version: String
    var content: String
}
