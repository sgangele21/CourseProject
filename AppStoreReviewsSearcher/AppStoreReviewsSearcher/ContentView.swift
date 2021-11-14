//
//  ContentView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var reviews: [Review]
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        Text("Hello, world!")
            .onAppear {
                Task {
                    do {
                        reviews = try await reviewsFetcher.fetchAllReviews()
                        print(reviews.count) // Prints 500
                    } catch(let error) {
                        print("❌ Error fetching Reviews: \(error)")
                    }
                    
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        ContentView(reviews: [])
    }
}
