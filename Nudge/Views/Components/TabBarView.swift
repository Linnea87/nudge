//
//  TabBarView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-04.
//

import SwiftUI

struct TabBarView: View {

    @Binding var selectedTab: Tab

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(
                icon: "person",
                label: String(localized: "profile_tab"),
                isSelected: selectedTab == .profile
            ) {
                selectedTab = .profile
            }

            TabBarButton(
                icon: "chart.bar",
                label: String(localized: "stats_tab"),
                isSelected: selectedTab == .stats
            ) {
                selectedTab = .stats
            }

            TabBarButton(
                icon: "checkmark.square",
                label: String(localized: "habits_tab"),
                isSelected: selectedTab == .habits
            ) {
                selectedTab = .habits
            }
        }
        .padding(Spacing.xs)
        .frame(height: Spacing.tabBarHeight)
        .background(Theme.nudgeSurface)
        .clipShape(Capsule())
        .padding(.horizontal, Spacing.lg)
        .padding(.bottom, Spacing.lg)
        .padding(.top, Spacing.sm)
    }
}

//==== TabBar Button =============================================

private struct TabBarButton: View {

    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: IconSize.md))
                Text(label)
                    .font(.system(size: FontSize.xs, weight: .semibold))
            }
            .foregroundStyle(isSelected ? Theme.nudgeTextPrimary : Theme.nudgeTextMuted)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isSelected ? Theme.nudgeAccent : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: Radius.full))
        }
    }
}
