//
//  TodoCardView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

struct TodoCardView: View {
    @ObservedObject var todo: TodoEntity
    @EnvironmentObject private var persistenceController: PersistenceController
    @State private var isDescriptionExpanded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(todo.isCompleted ? .green : Color(.label))
                    .onTapGesture {
                        persistenceController.toggleCompletion(for: todo)
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(todo.wrappedTitle)
                        .font(.title3)
                        .strikethrough(todo.isCompleted)
                        .foregroundColor(todo.isCompleted ? .secondary : Color(.label))
                    
                    if todo.wrappedDescription != "No description" {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isDescriptionExpanded.toggle()
                            }
                        }) {
                            HStack(spacing: 4) {
                                Text(isDescriptionExpanded ? "Hide details" : "Show details")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                Image(systemName: isDescriptionExpanded ? "chevron.compact.up" : "chevron.compact.down")
                                    .foregroundColor(.blue)
                                    .font(.caption)
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Spacer()
                
                // Delete button
                Button(action: {
                    persistenceController.deleteTodo(todo)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if isDescriptionExpanded && todo.wrappedDescription != "No description" {
                HStack {
                    Text(todo.wrappedDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                .padding(.leading, 28)
                .padding(.top, 4)
            }
        }
        .padding()
        .background(todo.isCompleted ? Color(.systemGray6) : Color(.secondarySystemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(todo.isCompleted ? Color.green.opacity(0.3) : Color(.label).opacity(0.2), lineWidth: todo.isCompleted ? 2 : 1)
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .scaleEffect(todo.isCompleted ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: todo.isCompleted)
        .contextMenu {
            Button(action: {
                persistenceController.toggleCompletion(for: todo)
            }) {
                Label(todo.isCompleted ? "Mark Incomplete" : "Mark Complete",
                      systemImage: todo.isCompleted ? "circle" : "checkmark.circle")
            }
            
            Button(role: .destructive, action: {
                persistenceController.deleteTodo(todo)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
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
    
    return TodoCardView(todo: todo)
        .environmentObject(PersistenceController.preview)
        .padding()
}
