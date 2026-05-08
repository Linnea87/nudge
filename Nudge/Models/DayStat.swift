import Foundation

struct DayStat: Identifiable {

    //==== Properties =============================================

    let id = UUID()
    let date: Date
    let count: Int

    //==== Computed =============================================

    var weekdayLabel: String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }
}
