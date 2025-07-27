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
    @State private var editMode: EditMode = .inactive
    @State private var selectedTodos: Set<TodoEntity> = []
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
                    if editMode == .active {
                        HStack {
                            Button("Select All") {
                                selectedTodos = Set(todos)
                            }
                            .disabled(selectedTodos.count == todos.count)
                            
                            Spacer()
                            
                            Text("\(selectedTodos.count) selected")
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button("Delete Selected") {
                                deleteSelectedTodos()
                            }
                            .foregroundColor(.red)
                            .disabled(selectedTodos.isEmpty)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                    }
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(todos) { todo in
                                HStack {
                                    if editMode == .active {
                                        Button(action: {
                                            toggleSelection(for: todo)
                                        }) {
                                            Image(systemName:  selectedTodos.contains(todo) ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(selectedTodos.contains(todo) ? .blue : .gray)
                                        }
                                        .padding(.leading)
                                    }
                                    
                                    TodoCardView(todo: todo)
                                        .onTapGesture {
                                            if editMode == .active {
                                                toggleSelection(for: todo)
                                            }
                                        }
                                }
                                .padding(.horizontal, editMode == .active ? 0 : 16)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("My Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editMode == .inactive {
                        Button(action: {
                            showingAddTodo = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                        }
                    } else {
                        Button("Done") {
                            editMode = .inactive
                            selectedTodos.removeAll()
                        }
                    }
                }
                
                if !todos.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if editMode == .inactive {
                            Button("Edit") {
                                editMode = .active
                            }
                        } else {
                            Button("Cancel") {
                                editMode = .inactive
                                selectedTodos.removeAll()
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoViewCoreData()
            }
            .onChange(of: editMode) { _, newValue in
                if newValue == .inactive {
                    selectedTodos.removeAll()
                }
            }
        }
    }
    
    private func toggleSelection(for todo: TodoEntity) {
        if selectedTodos.contains(todo) {
            selectedTodos.remove(todo)
        } else {
            selectedTodos.insert(todo)
        }
    }
    
    private func deleteSelectedTodos() {
        for todo in selectedTodos {
            persistenceController.deleteTodo(todo)
        }
        selectedTodos.removeAll()
        editMode = .inactive
    }
}

#Preview {
    TodoListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(PersistenceController.preview)
}
