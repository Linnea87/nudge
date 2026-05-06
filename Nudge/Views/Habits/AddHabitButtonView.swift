//
//  AddHabitButtonView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct AddHabitButtonView: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "plus.circle")
                    .font(.system(size: IconSize.lg))
                    .foregroundStyle(Theme.nudgeAccentLight)
                Text(String(localized: "habits_add_placeholder"))
                    .font(.system(size: FontSize.lg))
                    .foregroundStyle(Theme.nudgeTextMuted)
                Spacer()
            }
            .padding(Spacing.lg)
            .background(Theme.nudgeSurface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        }
    }
}
