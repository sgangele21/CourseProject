import Foundation
struct ReviewFilterer {
    enum FilterType: Int, Identifiable, CaseIterable {
        var id: UUID {
            UUID()
        }
        
        case last7Days
        case last30Days
        case last90Days
        case lastYear
        case allTime
        
        var title: String {
            switch self {
            case .last7Days:
                return "Last 7 Days"
            case .last30Days:
                return "Last 30 Days"
            case .last90Days:
                return "Last 90 Days"
            case .lastYear:
                return "Last Year"
            case .allTime:
                return "All Time"
            }
        }
    }
    
    let originalReviews: [Review]
    
    func filterReviews(by filterType: FilterType) -> [Review] {
        let currentDate = Date()
        
        var dayValueToAdd: Int
        
        switch filterType {
        case .last7Days:
            dayValueToAdd = -7
        case .last30Days:
            dayValueToAdd = -30
        case .last90Days:
            dayValueToAdd = -90
        case .lastYear:
            dayValueToAdd = -365
        case .allTime:
            dayValueToAdd = 
            
        }
        guard let fromDate = Calendar.current.date(byAdding: .day, value: dayValueToAdd, to: currentDate) else {
            assertionFailure("Issue adding dates")
            return originalReviews
        }
        return originalReviews.filter { review in
            review.date > fromDate
        }
    }
    
    
}
