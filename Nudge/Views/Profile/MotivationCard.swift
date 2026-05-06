//
//  MotivationCard.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct MotivationCard: View {

    let motivationMessage: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "sparkles")
                .font(.system(size: IconSize.lg))
                .foregroundStyle(Theme.nudgeAccentSoft)
            Text(motivationMessage)
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeAccentSoft)
            Spacer()
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.md)
        .background(Theme.nudgeSurface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
    }
}
