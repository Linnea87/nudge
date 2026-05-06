//
//  ProfileView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct ProfileView: View {

    //==== Properties =============================================

    @Binding var selectedTab: Tab

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        HeroView(
                            displayName: authVM.displayName,
                            userInitial: authVM.userInitial,
                            totalCheckIns: habitVM.totalCheckIns,
                            onSignOut: { authVM.signOut() }
                        )

                        MotivationView(motivationMessage: habitVM.motivationMessage)

                        ForEach(Categories.habitCategories, id: \.self) { category in
                            let habits = habitVM.habitsByCategory[category] ?? []
                            if !habits.isEmpty {
                                VStack(alignment: .leading, spacing: Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: FontSize.md, weight: .semibold))
                                        .foregroundStyle(Theme.nudgeTextMuted)

                                    ForEach(habits) { habit in
                                        HabitRowView(habit: habit) {
                                            Task {
                                                await habitVM.checkIn(habit)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(Spacing.lg)
                }

                TabBarView(selectedTab: $selectedTab)
            }
        }
        .task {
            guard let userId = authVM.userId else { return }
            await habitVM.fetchHabits(for: userId)
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
