//
//  SearchView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/23/21.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var reviews: [Review]
    @Binding var query: String
    @State var isLoading: Bool = false
    
    var body: some View {
        HStack {
            TextField("Search App Store Reviews", text: $query, prompt: Text("Enter query here"))
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Button("Search") {
                    fetchReviews()
                }
            }
        }
    }
    
    func fetchReviews() {
        isLoading = true
        Task(priority: .userInitiated) {
            do {
                let allReviews: [Review] = try await ReviewsFetcher().fetchAllReviews()
                let comparator = QueryComparator(reviews: allReviews, query: query)
                let sortedReviews = comparator.sortByMostSimlarReview()
                let reviewsCount = min(50, sortedReviews.count)
                reviews = Array(sortedReviews[0...reviewsCount])
                isLoading = false
            } catch(let error) {
                print("❌ Error: \(error)")
                isLoading = false
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @State static var reviews: [Review] = []
    @State static var query: String = ""
    
    static var previews: some View {
        SearchView(reviews: $reviews, query: $query)
    }
}
