import Foundation

class DateManager: ObservableObject {
    @Published var childBirthDate = Date()
    @Published var currentDate = Date()
    
    func calculatePregnancyWeek() -> Int {
        let totalPregnancyDays = 280
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: currentDate, to: childBirthDate)
        
        guard let daysUntilDueDate = components.day else {
            return 0
        }
        
        let daysPregnant = totalPregnancyDays - daysUntilDueDate
        let weeksPregnant = daysPregnant / 7
        
        return weeksPregnant
    }
}
