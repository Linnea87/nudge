import Foundation

protocol HabitServiceProtocol {

    //==== Fetch =============================================

    func fetchHabits(for userId: String) async throws -> [Habit]

    //==== Add =============================================

    func addHabit(_ habit: Habit) async throws

    //==== Update =============================================

    func updateHabit(_ habit: Habit) async throws

    //==== Delete =============================================

    func deleteHabit(_ habit: Habit) async throws

    //==== Check In =============================================

    func checkIn(_ habit: Habit, on date: Date) async throws
}
