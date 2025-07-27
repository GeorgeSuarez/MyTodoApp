//
//  TodoView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

struct TodoView: View {
    @State var todos: [Todo]
    @State var showingAddTodo = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                Text("Todo List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                    .padding(.top)
                
                LazyVStack(spacing: 12) {
                    ForEach(todos) { todo in
                        CardView(todo: todo)
                    }
                    .padding(.horizontal)
                }
            }
            
            Button(action: {
                showingAddTodo = true
            }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
        }
        .sheet(isPresented: $showingAddTodo) {
            AddTodoView(todos: $todos)
        }
    }
}


#Preview {
    TodoView(todos: Todo.sampleData)
}
