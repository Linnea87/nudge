//
//  HeroView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct HeroView: View {

    let displayName: String
    let userInitial: String
    let totalCheckIns: Int
    let onSignOut: () -> Void

    var body: some View {
        PrimaryCardView {
            HStack(spacing: Spacing.md) {
                ZStack {
                    Circle()
                        .fill(Theme.nudgeAccent)
                        .frame(width: IconSize.profileAvatar, height: IconSize.profileAvatar)
                    Text(userInitial)
                        .font(.system(size: FontSize.lg, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)
                }

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(displayName)
                        .font(.system(size: FontSize.xl, weight: .bold))
                        .foregroundStyle(Theme.nudgeTextPrimary)

                    Text(String(localized: "profile_member_since"))
                        .font(.system(size: FontSize.xs))
                        .foregroundStyle(Theme.nudgeTextMuted)

                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: IconSize.sm))
                        Text("\(totalCheckIns) \(String(localized: "profile_checkins_total"))")
                            .font(.system(size: FontSize.xs, weight: .semibold))
                    }
                    .foregroundStyle(Theme.nudgeTextPrimary)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xs)
                    .background(Theme.nudgeAccent)
                    .clipShape(Capsule())
                }

                Spacer()

                Button(action: onSignOut) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: IconSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
