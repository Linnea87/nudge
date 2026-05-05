//
//  StatsView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Charts
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

private struct StatsHeader: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "stats_this_week"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
                Text(String(localized: "stats_title"))
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
            }
            Spacer()
        }
    }
}

private struct TotalCard: View {

    let total: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "stats_total"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeAccentSoft)
                Text("\(total) \(String(localized: "stats_checkins"))")
                    .font(.system(size: FontSize.xxl, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
            }

            Spacer()

            Image(systemName: "bolt.fill")
                .font(.system(size: IconSize.xl))
                .foregroundStyle(Theme.nudgeAccentSoft)
        }
        .padding(Spacing.lg)
        .background(Theme.nudgeAccent)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}

private struct WeeklyChart: View {

    let data: [DayStat]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(String(localized: "stats_chart_title"))
                .font(.system(size: FontSize.sm, weight: .semibold))
                .foregroundStyle(Theme.nudgeTextPrimary)

            Chart(data) { stat in
                BarMark(
                    x: .value("Day", stat.weekdayLabel),
                    y: .value("Check-ins", stat.count)
                )
                .foregroundStyle(
                    Calendar.current.isDateInToday(stat.date)
                        ? Theme.nudgeSuccess
                        : Theme.nudgeAccent
                )
                .cornerRadius(Radius.sm)
            }
            .frame(height: Spacing.chartHeight)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
            .chartYAxis(.hidden)
        }
        .padding(Spacing.lg)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}

private struct HabitStatRow: View {

    let habit: Habit
    let count: Int

    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: habit.icon)
                .font(.system(size: IconSize.md))
                .foregroundStyle(Theme.nudgeAccentLight)
                .frame(width: IconSize.md, height: IconSize.md)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(habit.name)
                    .font(.system(size: FontSize.sm, weight: .semibold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                Text("\(count) \(String(localized: "stats_times_this_week"))")
                    .font(.system(size: FontSize.xs))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }

            Spacer()

            ZStack {
                Circle()
                    .fill(
                        count > 0
                            ? Theme.nudgeSuccess.opacity(0.15) : Theme.nudgeCard
                    )
                    .frame(width: IconSize.xl, height: IconSize.xl)
                Text("\(count)")
                    .font(.system(size: FontSize.sm, weight: .bold))
                    .foregroundStyle(
                        count > 0 ? Theme.nudgeSuccess : Theme.nudgeTextMuted
                    )
            }
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
