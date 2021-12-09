import AppKit

/// This is the URL we're going to use to fetch reviews from a server
extension URL {
    static let fetchAppStoreURL = URL(string: "https://itunes.apple.com/us/rss/customerreviews/id=398349296/sortby=mostrecent/json")!
}
