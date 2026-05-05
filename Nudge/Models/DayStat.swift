//
//  DayStat.swift
//  Nudge
//
//  Created by Linnéa on 2026-05-05.
//

import Foundation

struct DayStat: Identifiable {

    let id = UUID()
    let date: Date
    let count: Int

    var weekdayLabel: String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }
}
