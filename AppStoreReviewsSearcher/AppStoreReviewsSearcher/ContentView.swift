//
//  ContentView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var reviews: [Review] = []
    @State private var query: String = ""
    let reviewsFetcher = ReviewsFetcher()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search App Store Reviews", text: $query, prompt: Text("Enter query here"))
                Button("Search") {
                    print("Searching for: \(query)")
                }
            }.padding()
            Spacer()
        }.padding()
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
        ContentView()
    }
}
