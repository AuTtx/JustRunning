//
//  RunningData.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/24.
//

import SwiftUI

func date(year: Int, month: Int, day: Int = 1) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}
struct LocationData {
    /// A data series for the lines.
    struct Series: Identifiable {
        /// The name of the city.
        let city: String

        /// Average daily sales for each weekday.
        /// The `weekday` property is a `Date` that represents a weekday.
        let dis: [(weekday: Date, dis: Int)]

        /// The identifier for the series.
        var id: String { city }
    }

    /// Sales by location and weekday for the last 30 days.
    static let last30Days: [Series] = [
        .init(city: "晚上", dis: [
            (weekday: date(year: 2022, month: 5, day: 2), dis: 54),
            (weekday: date(year: 2022, month: 5, day: 3), dis: 42),
            (weekday: date(year: 2022, month: 5, day: 4), dis: 88),
            (weekday: date(year: 2022, month: 5, day: 5), dis: 49),
            (weekday: date(year: 2022, month: 5, day: 6), dis: 42),
            (weekday: date(year: 2022, month: 5, day: 7), dis: 125),
            (weekday: date(year: 2022, month: 5, day: 8), dis: 67)

        ]),
        .init(city: "白天", dis: [
            (weekday: date(year: 2022, month: 5, day: 2), dis: 81),
            (weekday: date(year: 2022, month: 5, day: 3), dis: 90),
            (weekday: date(year: 2022, month: 5, day: 4), dis: 52),
            (weekday: date(year: 2022, month: 5, day: 5), dis: 72),
            (weekday: date(year: 2022, month: 5, day: 6), dis: 84),
            (weekday: date(year: 2022, month: 5, day: 7), dis: 84),
            (weekday: date(year: 2022, month: 5, day: 8), dis: 137)
        ])
    ]

    /// The best weekday and location for the last 30 days.
    static let last30DaysBest = (
        city: "晚上",
        weekday: date(year: 2022, month: 5, day: 8),
        dis: 137
    )

    /// The best weekday and location for the last 12 months.
    static let last12MonthsBest = (
        city: "白天",
        weekday: date(year: 2022, month: 5, day: 8),
        dis: 113
    )

    /// Sales by location and weekday for the last 12 months.
    static let last12Months: [Series] = [
        .init(city: "晚上", dis: [
            (weekday: date(year: 2022, month: 5, day: 2), dis: 64),
            (weekday: date(year: 2022, month: 5, day: 3), dis: 60),
            (weekday: date(year: 2022, month: 5, day: 4), dis: 47),
            (weekday: date(year: 2022, month: 5, day: 5), dis: 55),
            (weekday: date(year: 2022, month: 5, day: 6), dis: 55),
            (weekday: date(year: 2022, month: 5, day: 7), dis: 105),
            (weekday: date(year: 2022, month: 5, day: 8), dis: 67)
        ]),
        .init(city: "白天", dis: [
            (weekday: date(year: 2022, month: 5, day: 2), dis: 57),
            (weekday: date(year: 2022, month: 5, day: 3), dis: 56),
            (weekday: date(year: 2022, month: 5, day: 4), dis: 66),
            (weekday: date(year: 2022, month: 5, day: 5), dis: 61),
            (weekday: date(year: 2022, month: 5, day: 6), dis: 60),
            (weekday: date(year: 2022, month: 5, day: 7), dis: 77),
            (weekday: date(year: 2022, month: 5, day: 8), dis: 113)
        ])
    ]
}
