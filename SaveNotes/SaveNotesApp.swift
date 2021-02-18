//
//  SaveNotesApp.swift
//  SaveNotes
//
//  Created by Andrei Serban on 18.02.2021.
//

import SwiftUI

@main
struct SaveNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
