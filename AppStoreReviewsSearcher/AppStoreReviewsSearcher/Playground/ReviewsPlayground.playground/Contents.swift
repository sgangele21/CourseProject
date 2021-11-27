import UIKit



let testReview = Review.testReviews.first!
print(testReview.simpleDate)
//// Store this to use in ContentView.swift
//Task {
//    do {
//        let allReviews: [Review] = try await ReviewsFetcher().fetchAllReviews()
//        let query = "Passport Subscription"
//        let comparator = QueryComparator(reviews: allReviews, query: query)
//        let sortedReviews = comparator.sortByMostSimlarReview()
//        print(sortedReviews.count)
//        for i in 0...10 {
//            print(sortedReviews[i].title)
//        }
//    } catch(let error) {
//        print(error)
//    }
//}
//print("Hello, do some work") // This is called first! since Task is asynchronous
var arr = [1,2,3]
