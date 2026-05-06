//
//  MotivationView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct MotivationView: View {

    let motivationMessage: String

    var body: some View {
        PrimaryCardView {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "sparkles")
                    .font(.system(size: IconSize.lg))
                    .foregroundStyle(Theme.nudgeAccentSoft)
                Text(motivationMessage)
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeAccentSoft)
                Spacer()
            }
        }
    }
}
