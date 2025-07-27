//
//  TodoView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

struct TodoView: View {
    @State var todos: [Todo]
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
               Text("Todo List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                    .padding(.top)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(todos) { todo in
                            HStack {
                                CardView(todo: todo)
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    TodoView(todos: Todo.sampleData)
}
