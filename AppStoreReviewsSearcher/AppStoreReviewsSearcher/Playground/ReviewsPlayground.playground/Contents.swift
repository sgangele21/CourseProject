import UIKit

//// Store this to use in ContentView.swift
Task {
    do {
        
        var allReviews: [Review]
        if let cachedReviews = Cache.getReviews() {
            print("Using cached reviews")
            allReviews = cachedReviews
        } else {
            print("Fetching reviews")
            allReviews = try await ReviewsFetcher().fetchAllReviews()
            Cache.put(reviews: allReviews)
        }
        let query = "Passport Subscription"
        let comparator = QueryComparator(reviews: allReviews, query: query)
        let sortedReviews = comparator.sortByMostSimlarReview()
        print(sortedReviews.count)
        for i in 0...10 {
            print(sortedReviews[i].title)
        }
    } catch(let error) {
        print(error)
    }
}
print("Hello, do some work") // This is called first! since Task is asynchronous
