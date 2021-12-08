//
//  SearcherListView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 12/7/21.
//

import SwiftUI

struct SearcherListView: View {
    
    @State var reviews: [Review] = []
    @State var query: String = ""
    @State var filterType: ReviewFilterer.FilterType = .allTime
    @State var isLoading: Bool = false
    @Binding var dataType: DataType
    
    var filteredReviews: [Review] {
        let reviewFilterer = ReviewFilterer(originalReviews: reviews)
        return reviewFilterer.filterReviews(by: filterType)
    }
    
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        List {
            SearchView(reviews: $reviews, query: $query, isLoading: $isLoading)
            Picker("", selection: $filterType) {
                ForEach(ReviewFilterer.FilterType.allCases) { filterType in
                    Text(filterType.title).tag(filterType)
                    
                }
            }.pickerStyle(.segmented)
            ForEach(filteredReviews) { review in
                ReviewView(review: review)
                    .listRowInsets(EdgeInsets())
                Divider()
            }
        }
        .navigationTitle("Searcher")
        if isLoading {
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
    }
}

struct SearcherListView_Previews: PreviewProvider {
    @State static var dataType: DataType = .wontLoad
    
    static var previews: some View {
        SearcherListView(dataType: $dataType)
    }
}
