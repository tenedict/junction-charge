import SwiftUI
import SwiftData

@main
struct Can_I_eat_gwamegi_App: App {
    @StateObject private var dateManager = DateManager()
    
    @AppStorage("savedChildBirthDate") var savedChildBirthDate: String?
        
    var body: some Scene {
        WindowGroup {
            EnterInformationView()
                .environmentObject(dateManager)
                .onAppear {
                    if let savedChildBirthDate = savedChildBirthDate {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy.MM.dd"
                        dateManager.childBirthDate = formatter.date(from: savedChildBirthDate)!
                    }
                }
        }
    }
}
