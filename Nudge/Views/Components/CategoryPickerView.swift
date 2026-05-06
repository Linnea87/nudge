//
//  CategoryPickerView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct CategoryPickerView: View {

    @Binding var selectedCategory: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            PickerHeaderView(
                label: selectedCategory.isEmpty
                    ? String(localized: "habits_choose_category")
                    : selectedCategory,
                isExpanded: isExpanded
            ) {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                PrimaryCardView {
                    VStack(spacing: Spacing.xs) {
                        ForEach(Categories.habitCategories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                                withAnimation {
                                    isExpanded = false
                                }
                            } label: {
                                HStack {
                                    Text(category)
                                        .font(.system(size: FontSize.md))
                                        .foregroundStyle(selectedCategory == category ? Theme.nudgeTextPrimary : Theme.nudgeTextMuted)
                                    Spacer()
                                    if selectedCategory == category {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: FontSize.sm))
                                            .foregroundStyle(Theme.nudgeSuccess)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
