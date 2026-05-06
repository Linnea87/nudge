//
//  IconPickerView.swift
//  Nudge
//
//  Created by Linnéa on 2026-04-28.
//

import SwiftUI

struct IconPickerView: View {

    @Binding var selectedIcon: String
    @State private var isExpanded = false

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            PickerHeaderView(
                label: selectedIcon.isEmpty
                    ? String(localized: "habits_choose_icon")
                    : String(localized: "habits_change_icon"),
                isExpanded: isExpanded,
                leadingIcon: selectedIcon.isEmpty ? nil : selectedIcon
            ) {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                LazyVGrid(columns: columns, spacing: Spacing.sm) {
                    ForEach(Symbols.habitIcons, id: \.self) { icon in
                        Button {
                            selectedIcon = icon
                            withAnimation {
                                isExpanded = false
                            }
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
}
