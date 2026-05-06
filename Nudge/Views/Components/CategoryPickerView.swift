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
        Picker(String(localized: "habits_choose_category"), selection: $selectedCategory) {
            ForEach(Categories.habitCategories, id: \.self) { category in
                Text(category).tag(category)
            }
        }
        .pickerStyle(.menu)
        .tint(Theme.nudgeAccentLight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Theme.nudgeCard)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
    }
}
