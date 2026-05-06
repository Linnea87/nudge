//
//  HabitsView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct HabitsView: View {

    //==== Properties =============================================

    @Binding var selectedTab: Tab

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM

    //==== State =============================================

    @State private var showAddHabit = false

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        HabitsHeader()

                        VStack(spacing: Spacing.sm) {
                            ForEach(habitVM.habits) { habit in
                                HabitRowView(habit: habit, onCheckIn: {}) {
                                    Task {
                                        await habitVM.deleteHabit(habit)
                                    }
                                }
                            }
                        }

                        AddHabitButton {
                            showAddHabit = true
                        }
                    }
                    .padding(Spacing.lg)
                }

                TabBarView(selectedTab: $selectedTab)
            }
        }
        .sheet(isPresented: $showAddHabit) {
            AddHabitView()
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

//==== HabitsHeader =============================================

private struct HabitsHeader: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "habits_title"))
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                Text(String(localized: "habits_subtitle"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
            Spacer()
        }
    }
}

//==== AddHabitButton =============================================

private struct AddHabitButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "plus.circle")
                    .font(.system(size: IconSize.lg))
                    .foregroundStyle(Theme.nudgeAccentLight)
                Text(String(localized: "habits_add_placeholder"))
                    .font(.system(size: FontSize.lg))
                    .foregroundStyle(Theme.nudgeTextMuted)
                Spacer()
            }
            .padding(Spacing.lg)
            .background(Theme.nudgeSurface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        }
    }
}
