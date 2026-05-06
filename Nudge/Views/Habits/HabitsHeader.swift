//
//  HabitsHeader.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct HabitsHeader: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "habits_title"))
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                Text(String(localized: "habits_subtitle"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
            Spacer()
        }
    }
}
