//
//  PrimaryButtonView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct PrimaryButtonView: View {

    let label: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView()
                        .tint(Theme.nudgeTextPrimary)
                } else {
                    Text(label)
                        .font(.system(size: FontSize.lg, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: Spacing.buttonHeight)
            .background(isDisabled ? Theme.nudgeTextMuted : Theme.nudgeAccent)
            .clipShape(RoundedRectangle(cornerRadius: Radius.full))
        }
        .disabled(isDisabled || isLoading)
    }
}
