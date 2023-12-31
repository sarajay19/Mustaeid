//
//  MustaeidApp.swift
//  Mustaeid
//
//  Created by Sara AlQuwaifli on 21/12/2023.
//

import SwiftUI
import SwiftData

@main
struct MustaeidApp: App {
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
            bottomSheet()
        }
        .modelContainer(sharedModelContainer)
    }
}
