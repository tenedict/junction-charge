import SwiftUI
import SwiftData

@main
struct Can_I_eat_gwamegi_App: App {
    @StateObject private var dateManager = DateManager()
    @StateObject private var viewModel = ContentViewModel()
    
    @AppStorage("savedChildBirthDate") var savedChildBirthDate: String?
        
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dateManager)
                .environmentObject(viewModel)
                .onAppear {
                    if let savedChildBirthDate = savedChildBirthDate {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy.MM.dd"
                        dateManager.childBirthDate = formatter.date(from: savedChildBirthDate)!
                    }
                }
                .onChange(of: dateManager.childBirthDate) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    savedChildBirthDate = formatter.string(from: dateManager.childBirthDate)
                }
        }
    }
}
