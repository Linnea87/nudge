//
//  PickerHeaderView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct PickerHeaderView: View {

    let label: String
    let isExpanded: Bool
    var leadingIcon: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            PrimaryCardView {
                HStack {
                    if let leadingIcon {
                        Image(systemName: leadingIcon)
                            .font(.system(size: IconSize.md))
                            .foregroundStyle(Theme.nudgeAccentLight)
                    }
                    Text(label)
                        .font(.system(size: FontSize.md))
                        .foregroundStyle(Theme.nudgeTextMuted)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
