import FirebaseFirestore
import Foundation

final class HabitService: HabitServiceProtocol {

    //==== Properties =============================================

    private let db = Firestore.firestore()
    private let collection = "habits"

    //==== Fetch =============================================

    func fetchHabits(for userId: String) async throws -> [Habit] {
        let snapshot = try await db.collection(collection)
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents.compactMap { document in
            try? document.data(as: Habit.self)
        }
    }

    //==== Add =============================================

    func addHabit(_ habit: Habit) async throws {
        try db.collection(collection)
            .document(habit.id)
            .setData(from: habit)
    }

    //==== Update =============================================

    func updateHabit(_ habit: Habit) async throws {
        try db.collection(collection)
            .document(habit.id)
            .setData(from: habit, merge: true)
    }

    //==== Delete =============================================

    func deleteHabit(_ habit: Habit) async throws {
        try await db.collection(collection)
            .document(habit.id)
            .delete()
    }

    //==== Check In =============================================

    func checkIn(_ habit: Habit, on date: Date) async throws {
        let timestamp = Timestamp(date: date)
        try await db.collection(collection)
            .document(habit.id)
            .updateData([
                "completedDates": FieldValue.arrayUnion([timestamp])
            ])
    }
}
