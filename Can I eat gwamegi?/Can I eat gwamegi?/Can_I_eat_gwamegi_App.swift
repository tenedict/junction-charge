//
//  Can_I_eat_gwamegi_App.swift
//  Can I eat gwamegi?
//
//  Created by 문재윤 on 8/10/24.
//

import SwiftUI
import SwiftData

@main
struct Can_I_eat_gwamegi_App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
