//
//  StatsView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct StatsView: View {

    //==== Properties =============================================

    @Binding var selectedTab: Tab

    //==== Environment =============================================

    @Environment(HabitViewModel.self) private var habitVM
    @Environment(StatsViewModel.self) private var statsVM

    //==== Body =============================================

    var body: some View {
        ZStack {
            Theme.nudgeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.none) {
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        StatsHeader()

                        TotalCard(
                            total: statsVM.totalCheckInsThisWeek(for: habitVM.habits)
                        )

                        WeeklyChart(
                            data: statsVM.checkInsPerDay(for: habitVM.habits)
                        )

                        VStack(spacing: Spacing.sm) {
                            ForEach(habitVM.habits) { habit in
                                HabitStatRow(
                                    habit: habit,
                                    count: statsVM.checkInsThisWeek(for: habit)
                                )
                            }
                        }
                    }
                    .padding(Spacing.lg)
                }

                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}
