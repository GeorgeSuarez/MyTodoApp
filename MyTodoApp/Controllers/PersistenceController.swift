//
//  PersistenceController.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/27/25.
//

import CoreData
import Foundation

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    // For preview purposes
        static var preview: PersistenceController = {
            let result = PersistenceController(inMemory: true)
            let viewContext = result.container.viewContext
            
            // Add sample data for previews
            let sampleTodos = [
                ("Check Emails", "Go through all emails and respond to any urgent ones.", false),
                ("Feed the dog and cat", "Make sure they have enough food and water.", false),
                ("Take out some frozen meat to defrost", "Take out the frozen porkchops from the freezer and put the meat in the fridge.", false)
            ]
            
            for (title, description, isCompleted) in sampleTodos {
                let todo = TodoEntity(context: viewContext)
                todo.id = UUID()
                todo.title = title
                todo.todoDescription = description
                todo.isCompleted = isCompleted
                todo.createdAt = Date()
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Preview data creation failed: \(nsError), \(nsError.userInfo)")
            }
            
            return result
        }()
        
        let container: NSPersistentContainer
        
        init(inMemory: Bool = false) {
            container = NSPersistentContainer(name: "TodoDataModel")
            
            if inMemory {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
            
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    print("Core Data error: \(error), \(error.userInfo)")
                }
            }
            
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        
        func save() {
            let context = container.viewContext
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    print("Save error: \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
    func addTodo(title: String, description: String) {
        let newTodo = TodoEntity(context: container.viewContext)
        newTodo.id = UUID()
        newTodo.title = title
        newTodo.todoDescription = description
        newTodo.isCompleted = false
        newTodo.createdAt = Date()
        
        save()
        
    }
    
    func deleteTodo(_ todo: TodoEntity) {
        container.viewContext.delete(todo)
        save()
    }
        
    func toggleCompletion(for todo: TodoEntity) {
            todo.isCompleted.toggle()
            save()
    }
    
}
