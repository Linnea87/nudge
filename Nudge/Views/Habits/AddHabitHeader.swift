//
//  AddHabitHeader.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct AddHabitHeader: View {

    let onDismiss: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "habits_title"))
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
                Text(String(localized: "habits_add_placeholder"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }

            Spacer()

            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: IconSize.md))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
        }
    }
}
