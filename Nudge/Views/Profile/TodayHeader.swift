//
//  TodayHeader.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct TodayHeader: View {

    let completedToday: Int
    let habitCount: Int

    var body: some View {
        HStack {
            Text(String(localized: "profile_today"))
                .font(.system(size: FontSize.xl, weight: .bold))
                .foregroundStyle(Theme.nudgeTextPrimary)
            Spacer()
            Text("\(completedToday) / \(habitCount) done")
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeSuccess)
        }
    }
}
