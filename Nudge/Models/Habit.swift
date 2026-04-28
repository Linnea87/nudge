//
//  Habit.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation

struct Habit: Identifiable, Codable {

    let id: UUID
    var name: String
    var icon: String
    var completedDates: [Date]
    var createdAt: Date
}
