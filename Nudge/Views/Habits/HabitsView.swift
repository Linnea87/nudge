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

    @Environment(AuthViewModel.self) var authVM
    @Environment(HabitViewModel.self) var habitVM

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
                                HabitManageRow(habit: habit) {
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

//==== HabitManageRow =============================================

private struct HabitManageRow: View {

    let habit: Habit
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName:habit.icon)
                .font(.system(size: FontSize.lg))
                .foregroundStyle(Theme.nudgeAccentLight)
                .frame(width: IconSize.md, height: IconSize.md)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(habit.name)
                    .font(.system(size: FontSize.lg, weight: .semibold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                
                Text("\(String(localized: "habits_created")) \(habit.createdAt.formatted(.dateTime.month(.abbreviated).day()))")
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)   
            }

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
        
        }
        .padding(Spacing.lg)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
     
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
    
    
