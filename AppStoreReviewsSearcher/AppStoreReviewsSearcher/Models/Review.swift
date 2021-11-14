import UIKit
/// Represents a users review of an app
struct Review: Identifiable, Equatable {
    let id = UUID()

    var rating: Int
    var title: String
    var version: String
    var content: String
}

extension Review {
    static let testReviews: [Review] = [
        Review(rating: 5, title: "Best App Ever", version: "6.0.0", content: "This app has been so helpful in me learning about nature. The Nature show especially is some of the best shows PBS has to offer"),
        Review(rating: 3, title: "App needs improvement", version: "3.9.0", content: "When watching a video, the audio seems to not work at random moments. Especially when using Chromecast. This doesn't happen on other apps, so I'm wondering what's going on here."),
        Review(rating: 1, title: "Video Progress not Saved", version: "2.5.0", content: "When I exit the app while playing the video and go back to the app, my progress isn't saved."),
        Review(rating: 4, title: "Love Ken Burns", version: "1.0.0", content: "I love the Muhammad Ali Documentary ❤️!")
    ]
}
