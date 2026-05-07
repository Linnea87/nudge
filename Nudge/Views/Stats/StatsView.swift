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
                    VStack(spacing: Spacing.xl) {

                        TotalStatView(
                            total: statsVM.totalCheckInsThisWeek(for: habitVM.habits)
                        )

                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text(String(localized: "stats_chart_title"))
                                .font(.system(size: FontSize.sm, weight: .semibold))
                                .foregroundStyle(Theme.nudgeTextMuted)

                            WeeklyChartView(
                                data: statsVM.checkInsPerDay(for: habitVM.habits)
                            )
                        }
                        .padding(.top, Spacing.lg)

                        ForEach(Categories.habitCategories, id: \.self) { category in
                            let habits = habitVM.habitsByCategory[category] ?? []
                            if !habits.isEmpty {
                                VStack(alignment: .leading, spacing: Spacing.sm) {
                                    Text(category)
                                        .font(.system(size: FontSize.md, weight: .semibold))
                                        .foregroundStyle(Theme.nudgeTextMuted)

                                    ForEach(habits) { habit in
                                        HabitStatView(
                                            habit: habit,
                                            count: statsVM.checkInsThisWeek(for: habit)
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.top, Spacing.xl)
                    }
                    .padding(Spacing.lg)
                }

                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}
