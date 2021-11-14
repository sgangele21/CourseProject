//
//  ReviewView.swift
//  AppStoreReviewsSearcher
//
//  Created by Sahil Gangele on 11/14/21.
//

import SwiftUI

struct ReviewView: View {
    let review: Review
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Spacer()
            HStack {
                Text(review.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(review.rating) / 5")
                    .font(.callout)
            }
            Text(review.content)
            Text(review.version)
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(review: Review.testReviews.first!)
    }
}
