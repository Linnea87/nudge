import SwiftUI

struct HabitRowView {

    //==== Properties =============================================

    let habit: Habit
    let onCheckIn: () -> Void

    //==== Body =============================================

    var body: some View {
        HStack(spacing: Spacing.md) {

            //==== Icon =============================================

            Image(systemName: habit.icon)
                .font(.system(size: IconSize.md))
                .foregroundStyle(Theme.nudgeAccentLight)
                .frame(width: IconSize.md, height: IconSize.md)
                
            //==== Text =============================================

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(habit.name)
                    .font(.system(size: FontSize.lg, weight: .semibold))
                    .foregroundStyle(Theme.nudgePrimary)

                Text("\(habit.completedDates.count) \(String(localized: "habits_sessions_total"))")
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }

            Spacer()

            //==== Check In Button =============================================

            Button(action: onCheckIn) {
                ZStack {
                    Circle()
                        .fill(habit.isCompletedToday ? Theme.nudgeSuccess : Theme.nudgeSurface)
                        .frame(width: IconSize.checkButton, height: IconSize.checkButton)

                    Image(systemName: habit.isCompletedToday ? "checkmark" : "circle.dashed")
                        .font(.system(size: IconSize.md))
                        .foregroundStyle(habit.isCompletedToday ? Theme.nudgeBackground : Theme.nudgeTextMuted)
                }
        
            }
            .disabled(habit.isCompletedToday)
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}