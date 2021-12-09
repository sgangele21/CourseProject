//
//  SearcherListView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 12/7/21.
//

import SwiftUI

/// This is the most important view in the app.
/// It contains the view `SearchView` and displays the list of Reviews
/// It also contains a filtering logic to filter reviews based on the date they were written
/// Lastly, it contains the label in the top right corner to display the Average Precision for test data
struct SearcherListView: View {
    
    @State var reviews: [Review] = []
    @State var query: String = ""
    @State var filterType: ReviewFilterer.FilterType = .allTime
    @State var isLoading: Bool = false
    @State var averagePrecision: String? = nil
    @Binding var dataType: DataType
    
    var filteredReviews: [Review] {
        let reviewFilterer = ReviewFilterer(originalReviews: reviews)
        return reviewFilterer.filterReviews(by: filterType)
    }
    
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        List {
            SearchView(reviews: $reviews, query: $query, isLoading: $isLoading, dataType: $dataType, averagePrecision: $averagePrecision)
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
        .toolbar {
            ToolbarItem(placement: .status) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(CGSize(width: 0.5, height: 0.5))
                }
            }
            ToolbarItem(placement: .automatic) {
                if let averagePrecision = averagePrecision {
                    VStack {
                        Text("Avg. Precision")
                            .font(.callout)
                        Text("\(averagePrecision)")
                            .font(.system(size: 10, design: .monospaced))
                    }
                    
                }
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
