//
//  Todo.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import Foundation
import SwiftUI

class Todo: Identifiable, ObservableObject {
    let id: UUID
    var title: String
    var description: String
    @Published var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, description: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}
