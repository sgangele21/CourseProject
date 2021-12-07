import AppKit

enum TestData {
    
    case worstAppEver
    case audioIssues
    case wontLoad
    
    
    var title: String {
        switch self {
        case .worstAppEver:
            return "Worst App Ever"
        case .audioIssues:
            return "Audio Issues"
        case .wontLoad:
            return "Love App"
        }
    }
    
    var reviews: [Review] {
        switch self {
        case .worstAppEver:
            return worstAppEverTestReviews()
        case .audioIssues:
            return audioIssuesTestReviews()
        case .wontLoad:
            return wontLoadTestReviews()
        }
    }
    
    func wontLoadTestReviews() -> [Review] {
        [
         Review(rating: 5, title: "WON'T LOAD", version: "4.2.0", content: "The app doesn't load when I try to open it. This prevents me from using this app altogether!", date: Date()),
         Review(rating: 5, title: "App doesn't load quickly", version: "3.1.0", content: "There is a slight between opening the app and actually using it. It's 10 seconds long, so it's quite noticeable", date: Date()),
         Review(rating: 4, title: "Loading times are slow", version: "6.1.0", content: "The loading times in this app are slower than it's competitorsk, which is deterring me from using this app.", date: Date()),
         Review(rating: 3, title: "Fix loading issues", version: "2.5.0", content: "When playing a video, I always get a loading indicator, even when I'm on WiFi! Please fix this", date: Date()),
         Review(rating: 2, title: "Problems with loading", version: "4.0.0", content: "I cannot playback any videos. All I get is a loading screen.", date: Date()),
         Review(rating: 1, title: "Loading times are much improved!", version: "5.4.0", content: "Thank you for fixing the slow loading times of the app.", date: Date()),
         Review(rating: 1, title: "App loads too quickly!", version: "6.1.0", content: "Wow, this app is now blazing fast! Thank you for updating it!", date: Date()),
         Review(rating: 1, title: "Fast app!", version: "5.2.0", content: "This app is much faster than Netflix, which is why I love it so much!", date: Date()),
         Review(rating: 1, title: "App is too expensive", version: "5.6.0", content: "Please lower the cost of this app or swtich to a Pay-Once model instead of a subscription model", date: Date()),
         Review(rating: 1, title: "App is #1", version: "5.2.0", content: "I'm a huge fan of this app. Keep pushing out great updates devs! You rock!", date: Date()),
        ]
    }
    
    func audioIssuesTestReviews() -> [Review] {
        [Review(rating: 1, title: "Audio Issues", version: "5.2.0", content: "Can't hear any audio when playing the video", date: Date()),
         Review(rating: 1, title: "Having trouble with noise", version: "5.6.0", content: "The audio goes in and out while playing video", date: Date()),
         Review(rating: 1, title: "Volume bugs", version: "5.2.0", content: "The volume control for the video player doesn't seem to work. Whenever I try to adjust it, the video is still on mute.", date: Date()),
         Review(rating: 1, title: "Video playback issues", version: "6.1.0", content: "The audio will at times drop when playing the video, specifically about 30 seconds in to a video.", date: Date()),
         Review(rating: 1, title: "Can't hear anything", version: "5.4.0", content: "I'm running into audio issues while playing my favorite videos. Please get devs to fix this ASAP!", date: Date()),
         Review(rating: 2, title: "App is decent", version: "4.0.0", content: "The app gets the job done, however I would like some bugs fixes, expecially with video playback.", date: Date()),
         Review(rating: 3, title: "App would be perfect if...", version: "2.5.0", content: "It wasn't so glitchy. I love the content and would enjoy it so much more if I could only get through watching the video", date: Date()),
         Review(rating: 4, title: "Nicely designed app", version: "6.1.0", content: "I liked the app, and it is nice to watch teh shows on demand rather than on the station schedule.", date: Date()),
         Review(rating: 5, title: "Thank you", version: "3.1.0", content: "This app has changed my life for the better. Just wanted to send a warm thank you to the devs!", date: Date()),
         Review(rating: 5, title: "Best App Ever", version: "4.2.0", content: "I love using this app to check my social media posts, and keep in touch with my loved ones!", date: Date())
        ]
    }
    
    /// 5 reviews on the top are very bad reviews, the bottom 5 are positive reviews
    /// The goal here is to allow one to test this against a list of queries and see
    /// how it would perfom against how a human would sort the list given the same query.
    func worstAppEverTestReviews() -> [Review] {
        [Review(rating: 1, title: "Worst App Ever", version: "5.2.0", content: "This app doesn't seem to work whenever I try to use it. The developers need to fix this", date: Date()),
         Review(rating: 1, title: "Bad app", version: "5.6.0", content: "I'm not able to find my viewing history anywhere and it seems this app doesn't keep track of it. It's frustrating when you ahve ot pay $60 for this service!", date: Date()),
         Review(rating: 1, title: "I don't like this app", version: "5.2.0", content: "The amount of money one needs to pay to use this app is ridiculous", date: Date()),
         Review(rating: 1, title: "Needs work", version: "6.1.0", content: "It would be ncie if the app could recommend videos to me based on what I like. Apps like Netflix and HBO already do this!", date: Date()),
         Review(rating: 1, title: "Audio Issues", version: "5.4.0", content: "I'm not able to find my viewing history anywhere and it seems this app doesn't keep track of it. It's frustrating when you have to pay $60 for this service!", date: Date()),
         Review(rating: 2, title: "App is decent", version: "4.0.0", content: "The app gets the job done, however I would like some bugs fixes, expecially with video playback.", date: Date()),
         Review(rating: 3, title: "App would be perfect if...", version: "2.5.0", content: "It wasn't so glitchy. I love the content and would enjoy it so much more if I could only get through watching the video", date: Date()),
         Review(rating: 4, title: "Nicely designed app", version: "6.1.0", content: "I liked the app, and it is nice to watch teh shows on demand rather than on the station schedule.", date: Date()),
         Review(rating: 5, title: "Thank you", version: "3.1.0", content: "This app has changed my life for the better. Just wanted to send a warm thank you to the devs!", date: Date()),
         Review(rating: 5, title: "Best App Ever", version: "4.2.0", content: "I love using this app to check my social media posts, and keep in touch with my loved ones!", date: Date())
        ]
    }
    
}
