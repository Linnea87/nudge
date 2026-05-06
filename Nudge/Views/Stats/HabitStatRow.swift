//
//  HabitStatRow.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct HabitStatRow: View {

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
                    .fill(count > 0 ? Theme.nudgeSuccess.opacity(0.15) : Theme.nudgeCard)
                    .frame(width: IconSize.xl, height: IconSize.xl)
                Text("\(count)")
                    .font(.system(size: FontSize.sm, weight: .bold))
                    .foregroundStyle(count > 0 ? Theme.nudgeSuccess : Theme.nudgeTextMuted)
            }
        }
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
