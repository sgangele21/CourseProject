# Documentation

## An overview of the function of the code (i.e., what it does and what it can be used for). 

### Goal
This is a macOS app to allow users to intelligently query / search their iOS App Store Reviews and display the results of the reviews in a ranked order by order of relevance of Review to query.

### Function
The user can query on various types of datasets containing lists of reviews, ranging from 3 mocked datasets created by me (“Worst App Ever” data, “Audio Issues” data, and “Won’t Load” data) to a “Live” data set that will fetch the 500 latest reviews for a particular app (right now the app is hardcoded to 1 particular app from the App Store) using the iTunes API.

The user can also view these datasets alone, to simply observe them in their truest form, prior to querying. This helps a user form queries if they have access at a glance to all the data they’re querying.

### User Interface
There are two main parts to this app
1. Searcher Screen
2. Test Data View Screen

The Searcher Screen allows a user to query the various datasets, and compare the reviews to the query. Once this comparison is done, this screen will display all the reviews in the data set  in a ranked list where the review at the top of the list is the most similar to the query, and the last review in the list is the least similar.

The Test Data View Screen is more of a helper screen to allow one to simply view the datasets in their purest form. If you select the “Live” data set, then you’ll be able to see all 500 reviews of the live data in order. If you select any other data set, you’ll be able to view the mocked data I’ve created.

### What it can be used for
Working in the iOS App Industry, source of feedback on your app is very important, as it helps you refine your software to be better for the end users. However, when looking at the feedback, there are times you want to simply search for certain issues pertaining to your app. Whether it be “Loading Issues” or “Audio Issues” etc. This feature is missing from AppStoreConnect.com, and slows down a developers progress in helping refine their app based on users feedback. Especially with larger apps, you can have up to thousands of user reviews. Having a system to query these results intelligently and display the reviews most related to the query is useful for developers, product managers and businesses that create iOS applications.

## Documentation of how the software is implemented with sufficient detail so that others can have a basic understanding of your code for future extension or any further improvement. 

### Tech Stack
* The macOS app is written in Swift 5 and utilizes SwiftUI for the UI Framework
* To build the app, I used Xcode 13 as the IDE
* The app runs on macOS 12 (Monterey) only. It does not support previous version of macOS as this utilizes new SwiftUI functionality that is only available on macOS 12
* To build the icons, Sketch was used
* No 3rd party libraries were used

The structure of the app can be broken down into a couple of categories, and these match up with the file structure I’ve created in the project as well.

#### NLP 
This folder contains all NLP related files.

⭐ `QueryComparator`: The entity that compares a list of reviews to a given query string. This contains Apple’s Natural Language Framework and is where the core of the NLP work is done in the app 

`RankEvaluator`: This evaluates a rank given a set of relevant documents. The purpose of this is the compute the average precision of a rank given it’s relevant document set

#### Networking
This folder contains all Networking related files.

`Cache`: Used to speed up network requests when fetching user reviews data. The persistence store of the cache is [UserDefaults](used to speed up network requests when fetching user reviews data)

`ReviewsFetcher`: Allows one to make a network request to the iTunes API to at least 500 user reviews for an app. The [iTunes API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html) is a public API made available by Apple.

#### Playground
This section contains a .playground file that can be used to test scratch code. This file doesn’t help any part of the UI, simply here for development purposes

#### Views
This folder contains all the UI of the app that is eventually shown to the user. This is where the data meets the UI and business logic.

`ContentView`: Main view of the app that contains the Sidebar and navigational links to the Searcher Screen & the Test Data Viewer Screen. Think of this as the root screen to all other screens.

`SearchView`: This is the view that contains the UI and logic for the search text field (user input), fetching the reviews, and passing them back to the `SearcherListView`. This view also passes back the data relating to the Average Precision.

`ReviewView`: This is the view that represents a Review object. It contains a title, rating, version number, and content. This will be a row in the list.

`SearcherListView`: This is the most important view in the app. It contains the view `SearchView` and displays the list of Reviews. It also contains a filtering logic to filter reviews based on the date they were written. Lastly, it contains the label in the top right corner to display the Average Precision for test data

`TestDataView`: This is a view created in order to view all the test data in the app, in their perfect form. The test data is shown in the right form. The top 5 of each of the lists are the relevant documents. The bottom five are not relevant. You can also view the Live Data, which is fetched from a server and is live user data.

#### Models
This folder contains the data models used in this app

`Review`: Represents a users review of an app

`ReviewVector`: Helper model to map a vector a a review together. It helps when sorting reviews based on their distance.

`TestData`: This represents the type of data currently being used in the app. It’s either one of the three mocked data sets (worstAppEver, audioIssues, wontLoad) or it’s the live data type which fetches a list of reviews from the server.

#### Helpers
These are random files that can’t be categorized anywhere, but are essential.

`ReviewFilterer`: This is helper struct for filtering reviews based on the date they were written

`URLExtensions`: This is the URL we’re going to use to fetch reviews from a server

#### Others
These are all files not within a group

`AppStoreReviewsSearcherApp`: This is the main view of the app that represents the window

`Assets`: Contains the png files related to the icon of the app


## Documentation of the usage of the software including either documentation of usages of APIs or detailed instructions on how to install and run a software, whichever is applicable. 

Requirements of computer
- User must be on a Mac (M1 or Intel based) running the latest version of macOS, which currently is macOS 12, Monterey. That’s it! No need to run any code, compile anything or even get into Xcode. This is a user oriented app, designed to be used by any developer that creates iOS apps.

1. Clone this repository, or download this repository from a zip file
2. Navigate to this directory
3. Observe the file containing `AppStoreReivewsSearcher.app`
4. Simply double click this and open the app up
	* If any dialogue appears saying “Do you want to open this app…?” Simply allow the app to be opened. I’ve had the app notarized by Apple, so it’s available for distribution to any other Mac
5. Start using it!

Alternatively, you could navigate to the AppStoreReviewsSearcher directory and open up the `AppStoreReviewsSearcher.xcodeproj` file. Then, simply click CMD + r to run the app natively on your Mac. This file contains all the source code needed for the app.

Here’s a run down of all the components in the app:

| After Launch | Searcher Screen | Test Data Viewer |
|--------------|-----------------|------------------|
| ![AppStoreReviewsSearcher-Annotated](https://user-images.githubusercontent.com/19801258/145335940-0a5fd87f-6c6c-4317-aef0-66916a1024e5.jpg) | ![AppStoreReviewsSearcher-Annotated](https://user-images.githubusercontent.com/19801258/145335961-7e55ee9f-e67e-4946-9447-25bb6b9633e6.jpg) | ![AppStoreReviewsSeracher-TestDataViewer-Annotated](https://user-images.githubusercontent.com/19801258/145335973-c1642bd8-dce1-40f4-9170-0b9166dbdab5.jpg) |







## Brief description of contribution of each team member in case of a multi-person team
Sahil Gangele -> Completed entire project.
