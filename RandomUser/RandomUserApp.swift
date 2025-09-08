//
//  RandomUserApp.swift
//  RandomUser
//
//  Created by Brayan Claros on 5/9/25.
//

import SwiftUI

@main
struct RandomUserApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(environment: AppEnvironment())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
