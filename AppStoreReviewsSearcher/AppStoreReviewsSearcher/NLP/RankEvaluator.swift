/// This evaluates a rank given a set of relevant documents.
/// The purpose of this is the compute the average precision of a rank given it's relevant document set
struct RankEvaluator {
    
    let relevantDocuments: Set<Review>
    let currentRank: [Review]
    
    init?(relevantDocuments: Set<Review>, currentRank: [Review]) {
        guard relevantDocuments.isEmpty == false && currentRank.isEmpty == false else { return nil }
        self.relevantDocuments = relevantDocuments
        self.currentRank = currentRank
    }
    
    func computeAveragePrecision() -> Double {
        var averagePrecision: Double = 0.0
        var numberOfRelevantDocsFound: Double = 0.0
        for (i, review) in currentRank.enumerated() {
            let currentIteration: Double = Double(i) + 1.0
            if relevantDocuments.contains(review) {
                numberOfRelevantDocsFound += 1
                averagePrecision += numberOfRelevantDocsFound / currentIteration
            }
        }
        return averagePrecision / Double(relevantDocuments.count)
    }
    
}
