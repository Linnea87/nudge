//
//  WeeklyChartView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import Charts
import SwiftUI

struct WeeklyChartView: View {

    let data: [DayStat]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(String(localized: "stats_chart_title"))
                .font(.system(size: FontSize.xs))
                .foregroundStyle(Theme.nudgeTextMuted)

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
