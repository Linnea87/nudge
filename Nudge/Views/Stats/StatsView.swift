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
                        PrimaryHeaderView(
                            title: String(localized: "stats_title"),
                            subtitle: String(localized: "stats_this_week")
                        )

                        TotalStatView(
                            total: statsVM.totalCheckInsThisWeek(for: habitVM.habits)
                        )

                        WeeklyChartView(
                            data: statsVM.checkInsPerDay(for: habitVM.habits)
                        )

                        VStack(spacing: Spacing.sm) {
                            ForEach(habitVM.habits) { habit in
                                HabitStatView(
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
