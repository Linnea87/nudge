//
//  WeeklyChart.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Charts
import SwiftUI

struct WeeklyChart: View {

    let data: [DayStat]

    var body: some View {
        PrimaryCard {
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
                            : stat.count > 0
                                ? Theme.nudgeAccent
                                : Theme.nudgeSurface
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
        }
    }
}
