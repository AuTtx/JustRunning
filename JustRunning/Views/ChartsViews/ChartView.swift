//
//  ChartView.swift
//  JustRunning
//
//  Created by 许智尧 on 2023/5/24.
//

import SwiftUI
import Charts

struct ChartView1: View {
    let data: [LocationData.Series]
    let bestSales: (city: String, weekday: Date, dis: Int)

    var body: some View {
        Chart(data) { series in
            ForEach(series.dis, id: \.weekday) { element in
                LineMark(
                    x: .value("Day", element.weekday, unit: .day),
                    y: .value("dis", element.dis)
                )
            }
            .foregroundStyle(by: .value("City", series.city))
            .symbol(by: .value("City", series.city))
            .interpolationMethod(.catmullRom)
        }
        .chartForegroundStyleScale([
            "白天": .purple,
            "晚上": .green
        ])
        .chartSymbolScale([
            "白天": Circle().strokeBorder(lineWidth: 2),
            "晚上": Square().strokeBorder(lineWidth: 2)
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
            }
        }
        .chartLegend(position: .top)
    }
}
    
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat
    
    init(inset: CGFloat = 0) {
        self.inset = inset
    }
    
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }
    
    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }
    
    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}

//struct LocationsOverview: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Day + Location with Most Sales")
//                .foregroundStyle(.secondary)
//            Text("Sundays in San Francisco")
//                .font(.title2.bold())
//            ChartView1()
//                .frame(height: 100)
//        }
//    }
//}
  
struct LocationsDetails: View {
    @State private var timeRange: TimeRange = .last30Days

    var bestSales: (city: String, weekday: Date, dis: Int) {
        switch timeRange {
        case .last30Days:
            return LocationData.last30DaysBest
        case .last12Months:
            return LocationData.last12MonthsBest
        }
    }

    var data: [LocationData.Series] {
        switch timeRange {
        case .last30Days:
            return LocationData.last30Days
        case .last12Months:
            return LocationData.last12Months
        }
    }

    var descriptionText: Text {
        let sales = bestSales.dis.formatted(.number)
        let weekday = bestSales.weekday.formatted(.dateTime.weekday(.wide))
        let city = bestSales.city
        let time: String
        switch timeRange {
        case .last30Days:
            time = "30 days"
        case .last12Months:
            time = "12 months"
        }
        return Text("此表为用模拟数据根据日期和跑步时间段生成的运动变化曲线")
    }

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)

                Text("根据跑步时间段（白天/黑夜）")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Text("每日跑步路程的变化曲线")
                    .font(.title2.bold())

                ChartView1(data: data, bestSales: bestSales)
                    .frame(height: 240)

                descriptionText
                    .font(.subheadline)
            }
            .listRowSeparator(.hidden)

            Section("Options") {
                TransactionsLink()
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Day + Location", displayMode: .inline)
        .navigationDestination(for: [Transaction].self) { transactions in
            TransactionsView(transactions: transactions)
        }
    }
}

struct ChartView1_Previews: PreviewProvider {
    static var previews: some View {
        LocationsDetails()
    }
}
