//
//  CardView.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var todo: Todo
    @State private var isDescriptionExpanded = false
    
    var backgroundColor: Color {
        if todo.isCompleted {
            return Color.green.opacity(0.15)
        } else {
            return Color.orange.opacity(0.1)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: todo.isCompleted ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(todo.isCompleted ? .green : .orange)
                    .onTapGesture {
                        todo.isCompleted.toggle()
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(todo.title)
                        .font(.title3)
                        .strikethrough(todo.isCompleted)
                        .foregroundColor(todo.isCompleted ? .secondary : .primary)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isDescriptionExpanded.toggle()
                        }
                    })  {
                        HStack(spacing: 4) {
                            Text(isDescriptionExpanded ? "Hide details" : "Show Details")
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
                
                Spacer()
            }
            
            if isDescriptionExpanded {
                HStack {
                    Text("Description: \(todo.description)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                .padding(.leading, 28)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                todo.isCompleted.toggle()
            }
        }
        .scaleEffect(todo.isCompleted ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: todo.isCompleted)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    let todo = Todo.sampleData[0]
    CardView(todo: todo)
        .background(Color.clear)
}
