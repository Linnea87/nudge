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

                        VStack(spacing: Spacing.sm) {
                            ForEach(habitVM.habits) { habit in
                                HabitRowView(habit: habit, onCheckIn: {}) {
                                    Task {
                                        await habitVM.deleteHabit(habit)
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
