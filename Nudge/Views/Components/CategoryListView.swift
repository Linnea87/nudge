import SwiftUI

struct CategoryListView: View {

    //==== Properties =============================================

    let habitsByCategory: [String: [Habit]]
    var onCheckIn: ((Habit) -> Void)? = nil
    var onDelete: ((Habit) -> Void)? = nil
    var onEdit: ((Habit) -> Void)? = nil
    var statsVM: StatsViewModel? = nil
    var showStreak: Bool = false

    //==== Body =============================================

    var body: some View {
        List {
            ForEach(Categories.habitCategories, id: \.self) { category in
                let habits = habitsByCategory[category] ?? []
                if !habits.isEmpty {
                    Section {
                        ForEach(habits) { habit in
                            HabitRowView(
                                habit: habit,
                                onCheckIn: onCheckIn.map { action in { action(habit) } },
                                onDelete: onDelete.map { action in { action(habit) } },
                                onEdit: onEdit.map { action in { action(habit) } },
                                weekCount: statsVM?.checkInsThisWeek(for: habit),
                                showStreak: showStreak
                            )
                        }
                    } header: {
                        Text(category)
                            .font(.system(size: FontSize.md, weight: .semibold))
                            .foregroundStyle(Theme.nudgeTextMuted)
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
