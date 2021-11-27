//
//  ContentView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var reviews: [Review] = []
    @State var query: String = ""
    @State var filterType: ReviewFilterer.FilterType = .allTime
    
    var filteredReviews: [Review] {
        let reviewFilterer = ReviewFilterer(originalReviews: reviews)
        return reviewFilterer.filterReviews(by: filterType)
    }
    
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        List {
            Section {
                HStack {
                    SearchView(reviews: $reviews, query: $query)
                }
                Picker("Filter Date", selection: $filterType) {
                    ForEach(ReviewFilterer.FilterType.allCases) { filterType in
                        Text(filterType.title).tag(filterType)
                        
                    }
                }.pickerStyle(.segmented)
            }
            ForEach(filteredReviews) { review in
                ReviewView(review: review)
                    .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(reviews: Review.testReviews)
    }
    
}
