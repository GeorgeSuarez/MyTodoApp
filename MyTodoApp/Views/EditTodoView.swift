//
//  EditTodoView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/27/25.
//

import SwiftUI

struct EditTodoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var persistenceController: PersistenceController
    @ObservedObject var todo: TodoEntity
    
    @State private var title: String
    @State private var description: String
    @FocusState private var titleFieldFocused: Bool
    
    init(todo: TodoEntity) {
        self.todo = todo
        self._title = State(initialValue: todo.wrappedTitle)
        self._description = State(initialValue: todo.wrappedDescription == "No Description" ? "" : todo.wrappedDescription)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    TextField("Enter todo title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($titleFieldFocused)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    TextField("Enter description (optional)", text: $description, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                }
                
                // Todo status toggle
                VStack(alignment: .leading, spacing: 8) {
                    Text("Status")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    HStack {
                        Button(action: {
                            if todo.isCompleted {
                                persistenceController.toggleCompletion(for: todo)
                            }
                        }) {
                            HStack {
                                Image(systemName: todo.isCompleted ? "circle" : "circle.fill")
                                Text("Not Completed")
                            }
                            .foregroundColor(todo.isCompleted ? .secondary : .primary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(todo.isCompleted ? Color.clear : Color.blue.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(todo.isCompleted ? Color.secondary : Color.blue, lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            if !todo.isCompleted {
                                persistenceController.toggleCompletion(for: todo)
                            }
                        }) {
                            HStack {
                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                                Text("Completed")
                            }
                            .foregroundColor(todo.isCompleted ? .green : .secondary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(todo.isCompleted ? Color.green.opacity(0.1) : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(todo.isCompleted ? Color.green : Color.secondary, lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTodo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                titleFieldFocused = true
            }
        }
    }
    
    private func saveTodo() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        
        todo.title = trimmedTitle
        todo.todoDescription = trimmedDescription.isEmpty ? "" : trimmedDescription
        
        persistenceController.save()
        dismiss()
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let todo = TodoEntity(context: context)
    todo.id = UUID()
    todo.title = "Sample Todo"
    todo.todoDescription = "This is a sample description"
    todo.isCompleted = false
    todo.createdAt = Date()
    
    return EditTodoView(todo: todo)
        .environmentObject(PersistenceController.preview)
}
