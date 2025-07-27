//
//  MyTodoAppApp.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

@main
struct MyTodoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(persistenceController)
        }
    }
}
