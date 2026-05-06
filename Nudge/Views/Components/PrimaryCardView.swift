//
//  PrimaryCardView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct PrimaryCardView<Content: View>: View {

    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(Spacing.lg)
            .background(Theme.nudgeCard)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
