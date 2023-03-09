//
//  GIMOATApp.swift
//  GIMOAT
//
//  Created by Felix on 3/9/23.
//

import SwiftUI

@main
struct GIMOATApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
