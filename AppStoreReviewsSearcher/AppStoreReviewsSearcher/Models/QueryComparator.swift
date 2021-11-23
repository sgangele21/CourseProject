import NaturalLanguage

/// Compares a list of revies to a given query string
struct QueryComparator {
    let reviews: [Review]
    let query: String
    static let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english)!
    
    func sortByMostSimlarReview() -> [Review] {
        let reviewVectors = reviews.compactMap { review -> ReviewVector? in
            let distance = QueryComparator.sentenceEmbedding.distance(between: review.title, and: query)
            return ReviewVector(review: review, distance: distance)
        }
        // The smaller the better!
        let sortedReviewsByMostConfident = reviewVectors.sorted { reviewVectorOne, reviewVectorTwo in
            reviewVectorOne.distance < reviewVectorTwo.distance
        }
        return sortedReviewsByMostConfident.map { $0.review }
    }
}
