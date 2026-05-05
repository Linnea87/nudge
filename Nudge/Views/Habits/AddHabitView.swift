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

                SaveButton(isDisabled: !isFormValid) {
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

//==== AddHabitHeader =============================================

private struct AddHabitHeader: View {

    let onDismiss: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "habits_title"))
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                Text(String(localized: "habits_add_placeholder"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }

            Spacer()

            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
        }
    }
}

//==== NameField =============================================

private struct NameField: View {

    @Binding var text: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "pencil")
                .foregroundStyle(Theme.nudgeTextMuted)
            TextField("", text: $text, prompt:
                Text(String(localized: "habits_name_placeholder"))
                    .foregroundStyle(Theme.nudgeTextMuted)
            )
            .foregroundStyle(Theme.nudgeTextPrimary)
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}

//==== IconPicker =============================================

private struct IconPicker: View {

    @Binding var selectedIcon: String

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(String(localized: "habits_choose_icon"))
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeTextMuted)

            LazyVGrid(columns: columns, spacing: Spacing.sm) {
                ForEach(Symbols.habitIcons, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                    } label: {
                        Image(systemName: icon)
                            .font(.system(size: IconSize.lg))
                            .foregroundStyle(selectedIcon == icon ? Theme.nudgeTextPrimary : Theme.nudgeTextMuted)
                            .frame(maxWidth: .infinity)
                            .padding(Spacing.sm)
                            .background(selectedIcon == icon ? Theme.nudgeAccent : Theme.nudgeCard)
                            .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                    }
                }
            }
        }
    }
}

//==== SaveButton =============================================

private struct SaveButton: View {

    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(String(localized: "habits_save"))
                .font(.system(size: FontSize.lg, weight: .bold))
                .foregroundStyle(Theme.nudgeTextPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: Spacing.buttonHeight)
                .background(isDisabled ? Theme.nudgeTextMuted : Theme.nudgeAccent)
                .clipShape(RoundedRectangle(cornerRadius: Radius.full))
        }
        .disabled(isDisabled)
    }
}
