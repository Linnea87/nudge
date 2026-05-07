//
//  StatsViewModel.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation

@Observable
final class StatsViewModel {

    //==== Public =============================================

    func totalCheckInsThisWeek(for habits: [Habit]) -> Int {
        habits.reduce(0) { $0 + checkInsThisWeek(for: $1) }
    }

    func checkInsThisWeek(for habit: Habit) -> Int {
        habit.completedDates.filter { isThisWeek($0) }.count
    }

    func checkInsPerDay(for habits: [Habit]) -> [DayStat] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).compactMap { offset -> DayStat? in
            guard let date = calendar.date(
                byAdding: .day,
                value: -6 + offset,
                to: today
            ) else { return nil }

            let count = habits.reduce(0) { total, habit in
                total + habit.completedDates.filter {
                    calendar.isDate($0, inSameDayAs: date)
                }.count
            }

            return DayStat(date: date, count: count)
        }
    }
    
    func statsMessage(for habits: [Habit]) -> String {
           let total = totalCheckInsThisWeek(for: habits)
           return total > 0
               ? "\(total) \(String(localized: "stats_total"))"
               : String(localized: "stats_no_checkins")
       }

    //==== Private =============================================

    private func isThisWeek(_ date: Date) -> Bool {
        Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }
}
