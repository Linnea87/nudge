import SwiftUI

struct HabitRowView: View {

    //==== Properties =============================================

    let habit: Habit
    var onCheckIn: (() -> Void)? = nil
    var onDelete: (() -> Void)? = nil
    var onEdit: (() -> Void)? = nil
    var weekCount: Int? = nil

    //==== Body =============================================

    var body: some View {
        PrimaryCardView {
            HStack(spacing: Spacing.md) {

                Image(systemName: habit.icon)
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeAccentLight)
                    .frame(width: IconSize.md, height: IconSize.md)

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(habit.name)
                        .font(.system(size: FontSize.lg, weight: .semibold))
                        .foregroundStyle(Theme.nudgeTextPrimary)

                    if let weekCount {
                        Text("\(weekCount) \(String(localized: "stats_times_this_week"))")
                            .font(.system(size: FontSize.xs))
                            .foregroundStyle(Theme.nudgeTextMuted)
                    }
                }

                Spacer()

                if let onCheckIn {
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

                if let weekCount {
                    ZStack {
                        Circle()
                            .fill(weekCount > 0 ? Theme.nudgeSuccess.opacity(0.15) : Theme.nudgeCard)
                            .frame(width: IconSize.xl, height: IconSize.xl)
                        Text("\(weekCount)")
                            .font(.system(size: FontSize.sm, weight: .bold))
                            .foregroundStyle(weekCount > 0 ? Theme.nudgeSuccess : Theme.nudgeTextMuted)
                    }
                }
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: Spacing.xs, leading: Spacing.none, bottom: Spacing.xs, trailing: Spacing.none))
        .swipeActions(edge: .trailing) {
            if let onDelete {
                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                }
            }
        }
        .swipeActions(edge: .leading) {
            if let onEdit {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                }
                .tint(Theme.nudgeAccent)
            }
        }
    }
}
