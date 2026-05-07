//
//  TotalStatView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct TotalStatView: View {

    let total: Int

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(String(localized: "stats_title"))
                .font(.system(size: FontSize.xxl, weight: .bold))
                .foregroundStyle(Theme.nudgeTextPrimary)

            HStack(spacing: Spacing.xs) {
                Text(total > 0
                    ? "\(total) \(String(localized: "stats_total"))"
                    : String(localized: "stats_no_checkins")
                )
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeTextMuted)
                Image(systemName: "heart")
                    .font(.system(size: FontSize.xs))
                    .foregroundStyle(Theme.nudgeTextMuted)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
