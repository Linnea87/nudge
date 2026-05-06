//
//  Habit.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation

struct Habit: Identifiable, Codable {

    let id: String
    let userId: String
    var name: String
    var icon: String
    var category: String
    var completedDates: [Date]
    var createdAt: Date
}

//==== Computed Properties =============================================

extension Habit {

    var isCompletedToday: Bool {
        let calendar = Calendar.current
        return completedDates.contains { calendar.isDateInToday($0) }
    }

    var currentStreak: Int {
        let calendar = Calendar.current

        let uniqueDays = Set(
            completedDates.map { calendar.startOfDay(for: $0) }
        )
        let sortedDays = uniqueDays.sorted(by: >)

        guard let latest = sortedDays.first else { return 0 }

        let today = calendar.startOfDay(for: Date())
        let daysSinceLatest =
            calendar.dateComponents([.day], from: latest, to: today).day ?? 0

        guard daysSinceLatest <= 1 else { return 0 }

        var streak = 1
        var expected = calendar.date(byAdding: .day, value: -1, to: latest)!

        for day in sortedDays.dropFirst() {
            guard day == expected else { break }
            streak += 1
            expected = calendar.date(byAdding: .day, value: -1, to: expected)!
        }

        return streak
    }
}
