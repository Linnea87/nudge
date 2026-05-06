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
                        PrimaryHeaderView(
                            title: String(localized: "habits_title"),
                            subtitle: String(localized: "habits_subtitle")
                        )

                        ForEach(Categories.habitCategories, id: \.self) { category in
                            let habits = habitVM.habitsByCategory[category] ?? []
                            if !habits.isEmpty {
                                VStack(alignment: .leading, spacing: Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: FontSize.md, weight: .semibold))
                                        .foregroundStyle(Theme.nudgeTextMuted)

                                    ForEach(habits) { habit in
                                        HabitRowView(habit: habit, onCheckIn: {}) {
                                            Task {
                                                await habitVM.deleteHabit(habit)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        AddHabitButtonView {
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
