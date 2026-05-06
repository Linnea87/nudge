//
//  AddHabitView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct AddHabitView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM
    @Environment(\.dismiss) private var dismiss

    //==== State =============================================

    @State private var name = ""
    @State private var selectedIcon = ""

    //==== Computed =============================================

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && !selectedIcon.isEmpty
    }

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        AddHabitHeader {
                            dismiss()
                        }

                        NameField(text: $name)

                        IconPicker(selectedIcon: $selectedIcon)
                    }
                    .padding(Spacing.lg)
                }

                PrimaryButton(
                    label: String(localized: "habits_save"),
                    isDisabled: !isFormValid
                ) {
                    Task {
                        guard let userId = authVM.userId else { return }
                        await habitVM.addHabit(
                            name: name,
                            icon: selectedIcon,
                            userId: userId
                        )
                        if habitVM.errorMessage == nil {
                            dismiss()
                        }
                    }
                }
                .padding(Spacing.lg)
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
