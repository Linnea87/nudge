//
//  PrimaryHeader.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct PrimaryHeader: View {

    let title: String
    var subtitle: String? = nil
    var onDismiss: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(.system(size: FontSize.display, weight: .bold))
                    .foregroundStyle(Theme.nudgeTextPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }

            Spacer()

            if let onDismiss {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: IconSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
