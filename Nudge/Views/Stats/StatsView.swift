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
                PrimaryHeaderView(
                    title: String(localized: "stats_title"),
                    subtitle: statsVM.statsMessage(for: habitVM.habits)
                )
                .padding(Spacing.lg)
                .padding(.bottom, Spacing.lg)

                WeeklyChartView(
                    data: statsVM.checkInsPerDay(for: habitVM.habits)
                )
                .padding(Spacing.lg)

                CategoryListView(
                    habitsByCategory: habitVM.habitsByCategory,
                    statsVM: statsVM
                )

                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}
