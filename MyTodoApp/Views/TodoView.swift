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
        VStack(alignment: .center) {
            Text("Todo")
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.blue)
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
