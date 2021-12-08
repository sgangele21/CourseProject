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
    @Binding var isLoading: Bool
    @Binding var dataType: DataType
    
    var body: some View {
        HStack {
            Text(Image(systemName: "magnifyingglass"))
            TextField("Search App Store Reviews", text: $query, prompt: Text("Enter query here"))
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .onSubmit {
                    fetchReviews()
                }
            
        }
    }
    
    func fetchReviews() {
        isLoading = true
        Task(priority: .userInitiated) {
            do {
                let allReviews: [Review] = try await ReviewsFetcher(dataType: dataType).fetchAllReviews()
                let comparator = QueryComparator(reviews: allReviews, query: query)
                let sortedReviews = comparator.sortByMostSimlarReview()
                let reviewsCount = min(50, sortedReviews.count - 1)
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
    @State static var isLoading: Bool = false
    @State static var dataType: DataType = .wontLoad
    
    static var previews: some View {
        SearchView(reviews: $reviews, query: $query, isLoading: $isLoading, dataType: $dataType)
    }
}
