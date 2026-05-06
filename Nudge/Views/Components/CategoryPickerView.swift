//
//  CategoryPickerView.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-06.
//

import SwiftUI

struct CategoryPickerView: View {

    @Binding var selectedCategory: String

    var body: some View {
        Menu {
            ForEach(Categories.habitCategories, id: \.self) { category in
                Button(category) {
                    selectedCategory = category
                }
            }
        } label: {
            PrimaryCardView {
                HStack {
                    Text(selectedCategory.isEmpty
                         ? String(localized: "habits_choose_category")
                         : selectedCategory
                    )
                    .font(.system(size: FontSize.md))
                    .foregroundStyle(selectedCategory.isEmpty ? Theme.nudgeTextMuted : Theme.nudgeTextPrimary)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: FontSize.sm))
                        .foregroundStyle(Theme.nudgeTextMuted)
                }
            }
        }
    }
}
