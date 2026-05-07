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
                            userInitial: authVM.userInitial,
                            displayName: authVM.displayName,
                            memberSince: authVM.memberSince,
                            onSignOut: { authVM.signOut() }
                        )

                        HStack(alignment: .top, spacing: Spacing.xs) {
                            VStack(alignment: .leading, spacing: Spacing.xs) {
                                HStack(spacing: Spacing.xs) {
                                    Text(authVM.greetingMessage)
                                        .font(.system(size: FontSize.xxl, weight: .bold))
                                        .foregroundStyle(Theme.nudgeTextPrimary)
                                    Image(systemName: authVM.greetingIcon)
                                        .font(.system(size: IconSize.md))
                                        .foregroundStyle(Theme.nudgeTextMuted)
                                }
                                Text(habitVM.motivationMessage)
                                    .font(.system(size: FontSize.sm))
                                    .foregroundStyle(Theme.nudgeAccentSoft)
                            }
                            Spacer()
                        }
                        .padding(.top, Spacing.md)

                        ForEach(Categories.habitCategories, id: \.self) { category in
                            let habits = habitVM.habitsByCategory[category] ?? []
                            if !habits.isEmpty {
                                VStack(alignment: .leading, spacing: Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: FontSize.md, weight: .semibold))
                                        .foregroundStyle(Theme.nudgeTextMuted)
                                        .padding(.top, Spacing.md)

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
