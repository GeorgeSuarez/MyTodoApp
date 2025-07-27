//
//  TodoListView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var persistenceController: PersistenceController
    @State private var showingAddTodo = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.createdAt, ascending: false)],
        animation: .default)
    private var todos: FetchedResults<TodoEntity>
    
    var body: some View {
        NavigationView {
            VStack {
                if todos.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No todos yet")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Tap the + button to add your first todo")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(todos) { todo in
                                TodoCardView(todo: todo)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("My Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTodo = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
                
                if !todos.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoViewCoreData()
            }
        }
    }
}

#Preview {
    TodoListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(PersistenceController.preview)
}
