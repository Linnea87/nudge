//
//  HabitViewModel.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Foundation

@Observable
final class HabitViewModel {

    //==== State =============================================

    private(set) var habits: [Habit] = []
    private(set) var isLoading: Bool = false
    var errorMessage: String?

    //==== Dependencies =============================================

    private let habitService: HabitServiceProtocol

    //==== Init =============================================

    init(habitService: HabitServiceProtocol) {
        self.habitService = habitService
    }

    //==== Computed =============================================

    var completedToday: Int {
        habits.filter { $0.isCompletedToday }.count
    }

    var totalCheckIns: Int {
        habits.reduce(0) { $0 + $1.completedDates.count }
    }

    var motivationMessage: String {
        let messages = [
            String(localized: "motivation_1"),
            String(localized: "motivation_2"),
            String(localized: "motivation_3")
        ]
        return messages[totalCheckIns % messages.count]
    }

    //==== Fetch =============================================

    func fetchHabits(for userId: String) async {
        isLoading = true
        errorMessage = nil

        do {
            habits = try await habitService.fetchHabits(for: userId)
        } catch {
            errorMessage = String(localized: "error_save_failed")
        }

        isLoading = false
    }
   
   //==== Add =======================================

   func addHabit(name: String, icon: String, userId: String) async {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = String(localized: "error_empty_name")
            return
        }

        let habit = Habit(
            id: UUID().uuidString,
            userId: userId,
            name: name,
            icon: icon,
            completedDates: [],
            createdAt: Date()
        )

        do {
            try await habitService.addHabit(habit)
            habits.append(habit)
        } catch {
            errorMessage = String(localized: "error_save_failed")
        }
   }

   //==== Delete =============================================

    func deleteHabit(_ habit: Habit) async {
          do {
                try await habitService.deleteHabit(habit)
                habits.removeAll { $0.id == habit.id }
          } catch {
                errorMessage = String(localized: "error_save_failed")
          }
    }

    //==== Check In =============================================

    func checkIn(_ habit: Habit) async {
        guard !habit.isCompletedToday else { return }

        do {
            try await habitService.checkIn(habit, on: Date())
            if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                habits[index].completedDates.append(Date())
            }
        } catch {
            errorMessage = String(localized: "error_save_failed")
        }
    }
}
