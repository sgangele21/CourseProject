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
    
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        List {
            Section {
                HStack {
                    SearchView(reviews: $reviews, query: $query)
                }
            }
            ForEach(reviews) { review in
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
