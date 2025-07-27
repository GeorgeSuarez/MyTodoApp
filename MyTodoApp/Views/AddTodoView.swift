//
//  AddTodoView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/26/25.
//

import SwiftUI

struct AddTodoView: View {
    @Binding var todos: [Todo]
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    TextField("Enter todo title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    TextField("Enter description (optional)", text: $description, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addTodo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private func addTodo() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
       
        let newTodo = Todo(title: trimmedTitle,
                          description: trimmedDescription.isEmpty ? "No details" : trimmedDescription,
                          isCompleted: false
        )
        
        todos.insert(newTodo, at: 0) // Adding new todo at the beginning
        dismiss()
        
    }
}

#Preview {
    @Previewable @State var previewTodos: [Todo] = []
    return AddTodoView(todos: $previewTodos)
}
