//
//  AddTodoViewCoreData.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/26/25.
//

import SwiftUI

struct AddTodoViewCoreData: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var persistenceController: PersistenceController
    @State private var title: String = ""
    @State private var description: String = ""
    @FocusState private var titleFieldFocused: Bool
    
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
            .onAppear {
                titleFieldFocused = true
            }
        }
    }
        
    private func addTodo() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        
        persistenceController.addTodo(
            title: trimmedTitle,
            description: trimmedDescription.isEmpty ? "" : trimmedDescription
        )
            
        dismiss()
    }
}

#Preview {
    AddTodoViewCoreData()
        .environmentObject(PersistenceController.preview)
}
