//
//  TestDataView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 12/7/21.
//

import SwiftUI
import Combine

struct TestDataView: View {
    
    @State var reviews: [Review] = []
    @State var isLoading: Bool = false
    @Binding var dataType: DataType
    
    var body: some View {
        List {
            ForEach(reviews) { review in
                ReviewView(review: review)
                    .listRowInsets(EdgeInsets())
                Divider()
            }
        }
        .navigationTitle("Test Data View")
        .onAppear(perform: {
            setReviews()
        })
        .onChange(of: Just(dataType)) { newValue in
            setReviews()
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(CGSize(width: 0.5, height: 0.5))
                }
            }
        }
    }
    
    func setReviews() {
        isLoading = true
        Task {
            do {
                reviews = try await dataType.reviews
                isLoading = false
            } catch(let error) {
                print("❌ Error: \(error)")
                isLoading = false
            }
        }
    }
}

struct TestDataView_Previews: PreviewProvider {
    @State static var dataType: DataType = .wontLoad
    static var previews: some View {
        TestDataView(dataType: $dataType)
    }
}
