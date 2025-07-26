//
//  TodoView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

struct TodoView: View {
    let todos: [Todo]
    
    var body: some View {
        VStack {
            Text("Todo App")
                .font(.title)
            List(todos) { todo in
                CardView(todo: todo)
                    .padding()
            }
        }
    }
}

#Preview {
    TodoView(todos: Todo.sampleData)
}
