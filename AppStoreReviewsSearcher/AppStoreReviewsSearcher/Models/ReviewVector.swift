import NaturalLanguage

/// Helper model to map a vector a a review together. It helps when sorting reviews based on their distance
struct ReviewVector: CustomStringConvertible {
    var description: String {
        return review.title
    }
    let review: Review
    let distance: NLDistance
}
