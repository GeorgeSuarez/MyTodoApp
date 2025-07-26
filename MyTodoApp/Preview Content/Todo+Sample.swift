//
//  Todo+Sample.swift
//  MyTodoApp
//
//  Created by George Suarez on 7/24/25.
//

import Foundation

extension Todo {
    static let sampleData: [Todo] =
    [
        Todo(title: "Check Emails",
            description: "Go through all emails and respond to any urgent ones.",
            isCompleted: false
            ),
        Todo(title: "Feed the dog and cat",
            description: "Make sure they have enough food and water.",
            isCompleted: false
            ),
        Todo(title: "Take out some frozen meat to defrost",
            description: "Take out the frozen porkchops from the freezer and put the meat in the fridge.",
            isCompleted: false
            ),
        Todo(title: "Send instagram reels to your significant other",
            description: "Send them your for you feed from this week",
            isCompleted: false
            ),
        Todo(title: "Finish fixing that annoying bug in production",
            description: "Maybe those dirty clankers will fix it for me",
            isCompleted: false
            ),
    ]
}

