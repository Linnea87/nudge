//
//  SaveButton.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct SaveButton: View {

    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(String(localized: "habits_save"))
                .font(.system(size: FontSize.lg, weight: .bold))
                .foregroundStyle(Theme.nudgeTextPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: Spacing.buttonHeight)
                .background(isDisabled ? Theme.nudgeTextMuted : Theme.nudgeAccent)
                .clipShape(RoundedRectangle(cornerRadius: Radius.full))
        }
        .disabled(isDisabled)
    }
}
