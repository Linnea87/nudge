//
//  IconPickerView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct IconPickerView: View {

    @Binding var selectedIcon: String

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(String(localized: "habits_choose_icon"))
                .font(.system(size: FontSize.sm))
                .foregroundStyle(Theme.nudgeTextMuted)

            LazyVGrid(columns: columns, spacing: Spacing.sm) {
                ForEach(Symbols.habitIcons, id: \.self) { icon in
                    Button {
                        selectedIcon = icon
                    } label: {
                        Image(systemName: icon)
                            .font(.system(size: IconSize.lg))
                            .foregroundStyle(selectedIcon == icon ? Theme.nudgeTextPrimary : Theme.nudgeTextMuted)
                            .frame(maxWidth: .infinity)
                            .padding(Spacing.sm)
                            .background(selectedIcon == icon ? Theme.nudgeAccent : Theme.nudgeCard)
                            .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                    }
                }
            }
        }
    }
}
