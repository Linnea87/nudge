//
//  TotalCard.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct TotalCard: View {

    let total: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(String(localized: "stats_total"))
                    .font(.system(size: FontSize.sm))
                    .foregroundStyle(Theme.nudgeAccentSoft)
                Text("\(total) \(String(localized: "stats_checkins"))")
                    .font(.system(size: FontSize.xxl, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)
            }

            Spacer()

            Image(systemName: "bolt.fill")
                .font(.system(size: IconSize.xl))
                .foregroundStyle(Theme.nudgeAccentSoft)
        }
        .padding(Spacing.lg)
        .background(Theme.nudgeAccent)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
