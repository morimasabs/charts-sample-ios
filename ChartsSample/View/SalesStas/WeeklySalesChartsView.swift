//
//  WeeklySalesChartsView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI
import Charts

struct WeeklySalesChartsView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    @State var rawSelectedDate: Date? = nil
    
    @Environment(\.calendar) var calendar
    
    var selectedDateValue: (day: Date, sales: Int)? {
        if let rawSelectedDate {
            
            return salesViewModel.salesByWeek.first(where: {
                let startOfWeek = $0.day
                let endOfWeek = endOfWeek(for: startOfWeek) ?? Date()
                return (startOfWeek ... endOfWeek).contains(rawSelectedDate)
            })
        }
        
        return nil
    }
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) {
            BarMark(x: .value("Week", $0.day, unit: .weekOfYear),
                    y: .value("Sales", $0.sales))
            // MARK: 集計してから渡すことで、1つの棒グラフ単位グラデーションをつけることができる
            .opacity(selectedDateValue == nil || $0.day == selectedDateValue?.day ? 1 : 0.5)
            
            if let rawSelectedDate {
                RuleMark(x: .value("Selected Day", rawSelectedDate, unit: .weekOfYear))
                    .foregroundStyle(Color.gray.opacity(0.3))
                    .offset(yStart: -10)
                    .zIndex(-1)
                    .annotation(
                        position: .top,
                        spacing: 0,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )
                    ) {
                        selectionPopover()
                    }
            }
        }
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    func selectionPopover() -> some View {
        if let _ = rawSelectedDate,
           let selectedDateValue {
            VStack {
                Text(selectedDateValue.day.formatted(.dateTime.month().day()))
                Text("\(selectedDateValue.sales) sales")
                    .bold()
                    .foregroundStyle(.blue)
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(color: .blue, radius: 2)
            }
        }
    }
    
    func endOfWeek(for startOfWeek: Date) -> Date? {
         calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }
}

struct PlainDataWeeklySalesChartsView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            // MARK: グラデーションが示す様に、それぞれのデータが積みか上がっていることがわかる
            BarMark(x: .value("Week", sale.saleDate, unit: .weekOfYear),
                    y: .value("Sales", sale.quantity))
            // MARK: グラデーションが示す様に、それぞれのデータが積みか上がっていることがわかる
            .foregroundStyle(Color.blue.gradient)
        }
    }
}

#Preview {
    WeeklySalesChartsView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain") {
    PlainDataWeeklySalesChartsView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
