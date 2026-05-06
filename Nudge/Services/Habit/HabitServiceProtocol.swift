//
//  HabitServiceProtocol.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-01.
//

import Foundation

protocol HabitServiceProtocol {
    func fetchHabits(for userId: String) async throws -> [Habit]
    func addHabit(_ habit: Habit) async throws
    func updateHabit(_ habit: Habit) async throws
    func deleteHabit(_ habit: Habit) async throws
    func checkIn(_ habit: Habit, on date: Date) async throws
}
