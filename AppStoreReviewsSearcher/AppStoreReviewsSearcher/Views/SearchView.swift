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
    @Binding var averagePrecision: String?
    
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
                defer {
                    isLoading = false
                }
                guard query.isEmpty == false else { return }
                let allReviews: [Review] = try await dataType.reviews
                let comparator = QueryComparator(reviews: allReviews, query: query)
                let sortedReviews = comparator.sortByMostSimlarReview()
                let reviewsCount = min(50, sortedReviews.count - 1)
                reviews = Array(sortedReviews[0...reviewsCount])
                displayAveragePrecision(for: reviews)
            } catch(let error) {
                print("❌ Error: \(error)")
                isLoading = false
            }
        }
    }
    
    func displayAveragePrecision(for currentRank: [Review]) {
        Task {
            guard let relevantDocuments = await dataType.relevanceDocuments,
                  let rankEvaluator = RankEvaluator(relevantDocuments: relevantDocuments, currentRank: currentRank)
            else {
                averagePrecision = nil
                return
            }
            let avgPrecisionStr = String(format: "%.2f", rankEvaluator.computeAveragePrecision())
            averagePrecision = avgPrecisionStr
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @State static var reviews: [Review] = []
    @State static var query: String = ""
    @State static var isLoading: Bool = false
    @State static var dataType: DataType = .wontLoad
    @State static var averagePrecision: String? = nil
    
    static var previews: some View {
        SearchView(reviews: $reviews, query: $query, isLoading: $isLoading, dataType: $dataType, averagePrecision: $averagePrecision)
    }
}
