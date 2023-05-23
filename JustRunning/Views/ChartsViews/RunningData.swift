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
        let sales: [(weekday: Date, sales: Int)]

        /// The identifier for the series.
        var id: String { city }
    }

    /// Sales by location and weekday for the last 30 days.
    static let last30Days: [Series] = [
        .init(city: "Cupertino", sales: [
            (weekday: date(year: 2022, month: 5, day: 2), sales: 54),
            (weekday: date(year: 2022, month: 5, day: 3), sales: 42),
            (weekday: date(year: 2022, month: 5, day: 4), sales: 88),
            (weekday: date(year: 2022, month: 5, day: 5), sales: 49),
            (weekday: date(year: 2022, month: 5, day: 6), sales: 42),
            (weekday: date(year: 2022, month: 5, day: 7), sales: 125),
            (weekday: date(year: 2022, month: 5, day: 8), sales: 67)

        ]),
        .init(city: "San Francisco", sales: [
            (weekday: date(year: 2022, month: 5, day: 2), sales: 81),
            (weekday: date(year: 2022, month: 5, day: 3), sales: 90),
            (weekday: date(year: 2022, month: 5, day: 4), sales: 52),
            (weekday: date(year: 2022, month: 5, day: 5), sales: 72),
            (weekday: date(year: 2022, month: 5, day: 6), sales: 84),
            (weekday: date(year: 2022, month: 5, day: 7), sales: 84),
            (weekday: date(year: 2022, month: 5, day: 8), sales: 137)
        ])
    ]

    /// The best weekday and location for the last 30 days.
    static let last30DaysBest = (
        city: "San Francisco",
        weekday: date(year: 2022, month: 5, day: 8),
        sales: 137
    )

    /// The best weekday and location for the last 12 months.
    static let last12MonthsBest = (
        city: "San Francisco",
        weekday: date(year: 2022, month: 5, day: 8),
        sales: 113
    )

    /// Sales by location and weekday for the last 12 months.
    static let last12Months: [Series] = [
        .init(city: "Cupertino", sales: [
            (weekday: date(year: 2022, month: 5, day: 2), sales: 64),
            (weekday: date(year: 2022, month: 5, day: 3), sales: 60),
            (weekday: date(year: 2022, month: 5, day: 4), sales: 47),
            (weekday: date(year: 2022, month: 5, day: 5), sales: 55),
            (weekday: date(year: 2022, month: 5, day: 6), sales: 55),
            (weekday: date(year: 2022, month: 5, day: 7), sales: 105),
            (weekday: date(year: 2022, month: 5, day: 8), sales: 67)
        ]),
        .init(city: "San Francisco", sales: [
            (weekday: date(year: 2022, month: 5, day: 2), sales: 57),
            (weekday: date(year: 2022, month: 5, day: 3), sales: 56),
            (weekday: date(year: 2022, month: 5, day: 4), sales: 66),
            (weekday: date(year: 2022, month: 5, day: 5), sales: 61),
            (weekday: date(year: 2022, month: 5, day: 6), sales: 60),
            (weekday: date(year: 2022, month: 5, day: 7), sales: 77),
            (weekday: date(year: 2022, month: 5, day: 8), sales: 113)
        ])
    ]
}
