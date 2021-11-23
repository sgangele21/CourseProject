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
    
    var body: some View {
        HStack {
            TextField("Search App Store Reviews", text: $query, prompt: Text("Enter query here"))
            Button("Search") {
                Task {
                    do {
                        let allReviews: [Review] = try await ReviewsFetcher().fetchAllReviews()
                        let comparator = QueryComparator(reviews: allReviews, query: query)
                        let sortedReviews = comparator.sortByMostSimlarReview()
                        let reviewsCount = min(50, sortedReviews.count)
                        reviews = Array(sortedReviews[0...reviewsCount])
                    }catch(let error) {
                        print("❌ Error: \(error)")
                    }
                    
                }
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
