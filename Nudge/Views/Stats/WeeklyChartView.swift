import Charts
import SwiftUI

struct WeeklyChartView: View {

    //==== Properties =============================================

    let data: [DayStat]

    //==== Body =============================================

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(String(localized: "stats_chart_title"))
                .font(.system(size: FontSize.sm))
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
            .frame(height: Height.chart)
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
