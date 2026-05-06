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
    @State private var habitToEdit: Habit? = nil

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                VStack(spacing: Spacing.lg) {
                    PrimaryHeaderView(
                        title: String(localized: "habits_title"),
                        subtitle: String(localized: "habits_subtitle")
                    )
                }
                .padding(Spacing.lg)

                List {
                    ForEach(Categories.habitCategories, id: \.self) { category in
                        let habits = habitVM.habitsByCategory[category] ?? []
                        if !habits.isEmpty {
                            Section {
                                ForEach(habits) { habit in
                                    HabitRowView(habit: habit)
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                Task {
                                                    await habitVM.deleteHabit(habit)
                                                }
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                habitToEdit = habit
                                            } label: {
                                                Image(systemName: "pencil")
                                            }
                                            .tint(Theme.nudgeAccent)
                                        }
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(
                                            top: Spacing.xs,
                                            leading: Spacing.none,
                                            bottom: Spacing.xs,
                                            trailing: Spacing.none
                                        ))
                                }
                            } header: {
                                Text(category)
                                    .font(.system(size: FontSize.md, weight: .semibold))
                                    .foregroundStyle(Theme.nudgeTextMuted)
                            }
                        }
                    }

                    AddHabitButtonView {
                        showAddHabit = true
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(
                        top: Spacing.xs,
                        leading: Spacing.none,
                        bottom: Spacing.xs,
                        trailing: Spacing.none
                    ))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)

                TabBarView(selectedTab: $selectedTab)
            }
        }
        .sheet(isPresented: $showAddHabit) {
            HabitFormView()
        }
        .sheet(item: $habitToEdit) { habit in
            HabitFormView(habit: habit)
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
