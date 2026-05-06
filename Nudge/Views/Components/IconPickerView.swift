//
//  IconPickerView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//


import SwiftUI

struct IconPickerView: View {

    @Binding var selectedIcon: String
    @State private var isExpanded = false

    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    if !selectedIcon.isEmpty {
                        Image(systemName: selectedIcon)
                            .font(.system(size: IconSize.md))
                            .foregroundStyle(Theme.nudgeAccentLight)
                    }
                    Text(selectedIcon.isEmpty
                         ? String(localized: "habits_choose_icon")
                         : String(localized: "habits_change_icon")
                    )
                    .font(.system(size: FontSize.md))
                    .foregroundStyle(selectedIcon.isEmpty ? Theme.nudgeTextMuted : Theme.nudgeTextPrimary)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
                .padding(Spacing.md)
                .background(Theme.nudgeCard)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
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
