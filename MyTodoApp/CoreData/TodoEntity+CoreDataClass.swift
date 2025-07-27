//
//  TodoEntity+CoreDataClass.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/27/25.
//

import Foundation
import CoreData

@objc(TodoEntity)
public class TodoEntity: NSManagedObject, Identifiable {
    
}

extension TodoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var todoDescription: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var createdAt: Date?
    
}

extension TodoEntity {
    var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    var wrappedDescription: String {
        todoDescription ?? "No Description"
    }
    
    var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
}

