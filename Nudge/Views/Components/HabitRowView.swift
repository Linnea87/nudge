//
//  HabitRowView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct HabitRowView: View {

    //==== Properties =============================================

    let habit: Habit
    let onCheckIn: () -> Void
    var onDelete: (() -> Void)? = nil

    //==== Body =============================================

    var body: some View {
        PrimaryCard {
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
                        .foregroundStyle(Theme.nudgeTextPrimary)

                    Text("\(habit.completedDates.count) \(String(localized: "habits_sessions_total"))")
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }

                Spacer()

                //==== Action Button =============================================

                if let onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .font(.system(size: IconSize.md))
                            .foregroundStyle(Theme.nudgeTextMuted)
                    }
                } else {
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
            }
        }
    }
}
