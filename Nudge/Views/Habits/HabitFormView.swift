import SwiftUI

struct HabitFormView: View {

    //==== Properties =============================================

    var habit: Habit? = nil

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM
    @Environment(\.dismiss) private var dismiss

    //==== State =============================================

    @State private var name = ""
    @State private var selectedIcon = ""
    @State private var selectedCategory = ""

    //==== Computed =============================================

    private var isEditing: Bool { habit != nil }

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !selectedIcon.isEmpty &&
        !selectedCategory.isEmpty
    }

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        PrimaryHeaderView(
                            title: String(localized: isEditing ? "habits_edit_title" : "habits_title"),
                            subtitle: String(localized: "habits_add_placeholder"),
                            onDismiss: { dismiss() }
                        )

                        NameFieldView(text: $name)

                        CategoryPickerView(selectedCategory: $selectedCategory)

                        IconPickerView(selectedIcon: $selectedIcon)
                    }
                    .padding(Spacing.lg)
                }

                PrimaryButtonView(
                    label: String(localized: isEditing ? "habits_save_changes" : "habits_save"),
                    isDisabled: !isFormValid
                ) {
                    Task {
                        if isEditing {
                            guard var updatedHabit = habit else { return }
                            updatedHabit.name = name
                            updatedHabit.icon = selectedIcon
                            updatedHabit.category = selectedCategory
                            await habitVM.updateHabit(updatedHabit)
                        } else {
                            guard let userId = authVM.userId else { return }
                            await habitVM.addHabit(
                                name: name,
                                icon: selectedIcon,
                                category: selectedCategory,
                                userId: userId
                            )
                        }
                        if habitVM.errorMessage == nil {
                            dismiss()
                        }
                    }
                }
                .padding(Spacing.lg)
            }
        }
        .onAppear {
            if let habit {
                name = habit.name
                selectedIcon = habit.icon
                selectedCategory = habit.category
            }
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
