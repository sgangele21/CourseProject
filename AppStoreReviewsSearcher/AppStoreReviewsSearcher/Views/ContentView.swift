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
    @State var isLoading: Bool = false
    @State var dataType: DataType = .live
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
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
              Menu {
                  ForEach(DataType.allCases, id: \.self) { testData in
                      Button {
                          self.dataType = testData
                      } label: {
                          Image(systemName: testData.imageName)
                          Text("\(testData.title)")
                      }
                  }
                } label: {
                    Image(systemName: dataType.imageName)
                }
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

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(reviews: Review.testReviews)
    }
    
}
