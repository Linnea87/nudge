//
//  ContentView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct ProfileView: View {

    //==== Environment =============================================

    @Environment(AuthViewModel.self) private var authVM
    @Environment(HabitViewModel.self) private var habitVM

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.lg) {
                    heroCard
                    motivationCard
                    todayHeader

                    VStack(spacing: Spacing.sm) {
                        ForEach(habitVM.habits) { habit in
                            HabitRowView(habit: habit) {
                                Task {
                                    await habitVM.checkIn(habit)
                                }
                            }
                        }
                    }
                }
                .padding(Spacing.lg)
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

    //==== Hero Card =============================================

    private var heroCard: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(Theme.nudgeAccent)
                    .frame(width: IconSize.profileAvatar, height: IconSize.profileAvatar)

                Text(authVM.userInitial)
                    .font(.system(size: FontSize.lg, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
            }

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(authVM.displayName)
                    .font(.system(size: FontSize.xl, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                
                Text(String(localized: "profile_member_since"))
                    .font(.system(size: FontSize.xs))
                    .foregroundStyle(Theme.nudgeTextMuted)
                
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "zap.fill")
                        .font(.system(size: IconSize.sm))
                    Text("\(habitVM.totalCheckIns) \(String(localized: "profile_checkins_total"))")
                        .font(.system(size: FontSize.xs, weight: .semibold))
                    
                }
                .foregroundStyle(Theme.nudgeTextPrimary)
                .padding(.horizontal, Spacing.sm)
                .padding(.vertical, Spacing.xs)
                .background(Theme.nudgeAccent)
                .clipShape(Capsule())
            }

            Spacer()

            Button {
                authVM.signOut()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }


        }
        .padding(Spacing.lg)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.xl))
    }

    //==== Motivation Card =============================================

    private var motivationCard: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "sparkles")
                .font(.system(size: IconSize.lg))
                .foregroundStyle(Theme.nudgeAccentSoft)
            
            Text(habitVM.motivationMessage)
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeAccentSoft)
            Spacer()
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.md)
        .background(Theme.nudgeSurface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
    }

    //==== Today Header =============================================

    private var todayHeader: some View {
        HStack {
            Text(String(localized: "profile_today"))
                .font(.system(size: FontSize.xl, weight: .bold))
                .foregroundStyle(Theme.nudgeTextPrimary)

            Spacer()

            Text("\(habitVM.completedToday) / \(habitVM.habits.count) done")
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeSuccess)
        }
    }
}

#Preview {
    ProfileView()
}
