import SwiftUI

struct HabitsView: View {

    //==== Properties =============================================

    @Binding var selectedTab: Tab

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM

    //==== State =============================================

    @State private var showAddHabit = false
    @State private var habitToEdit: Habit? = nil

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                VStack(spacing: Spacing.lg) {
                    PrimaryHeaderView(
                        title: String(localized: "habits_title"),
                        subtitle: String(localized: "habits_subtitle"),
                        onAdd: { showAddHabit = true }
                    )
                }
                .padding(Spacing.lg)

                CategoryListView(
                    habitsByCategory: habitVM.habitsByCategory,
                    onDelete: { habit in Task { await habitVM.deleteHabit(habit) } },
                    onEdit: { habit in habitToEdit = habit }
                )

                TabBarView(selectedTab: $selectedTab)
            }
        }
        .sheet(isPresented: $showAddHabit) {
            HabitFormView()
        }
        .sheet(item: $habitToEdit) { habit in
            HabitFormView(habit: habit)
        }
        .alert(
            String(localized: "error_title"),
            isPresented: Binding(
                get: { habitVM.errorMessage != nil },
                set: { if !$0 { habitVM.errorMessage = nil } }
            ),
            presenting: habitVM.errorMessage
        ) { _ in
            Button(String(localized: "error_ok"), role: .cancel) { }
        } message: { errorMessage in
            Text(errorMessage)
        }
    }
}
