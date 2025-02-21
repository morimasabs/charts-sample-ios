//
//  DailySalesCharsView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI
import Charts

struct DailySalesCharsView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    let numberOfDisplayedDays = 30
    
    @State var scrollPosition: TimeInterval = TimeInterval()

    init(salesViewModel: SalesViewModel) {
        self.salesViewModel = salesViewModel
        
        guard let lastDate = salesViewModel.salesData.last?.saleDate else { return }
        let beginingOfInterval = lastDate.addingTimeInterval(-1 * 3600 * 24 * 30)
          
        self._scrollPosition = State(initialValue: beginingOfInterval.timeIntervalSinceReferenceDate)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("\(scrollPositionString) – \(scrollPositionEndString)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Chart(salesViewModel.salesByDay, id: \.day) { saleData in
                BarMark(x: .value("Day", saleData.day, unit: .day),
                        y: .value("Sales", saleData.sales))
                .foregroundStyle(Color.blue.gradient)
            }
            .chartScrollableAxes(.horizontal)
            // 30日分のデータを表示したい。
            // unitを.dayにしているため、Double型で指定する必要がある。
            .chartXVisibleDomain(length: 3600 * 24 * numberOfDisplayedDays)
            // スクロールを離したときに月の始まり（1日）にスナップする
            .chartScrollTargetBehavior(
                .valueAligned(
                    matching: .init(hour: 0),
                    majorAlignment: .matching(.init(day: 1))))
            .chartScrollPosition(x: $scrollPosition)
        }
    }
    
    var scrollPositionStart: Date {
        Date(timeIntervalSinceReferenceDate: scrollPosition)
    }
    
    var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    var scrollPositionString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    
    var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
}

struct PlainDataDailySalesCharsView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Week", sale.saleDate, unit: .day),
                    y: .value("Sales", sale.quantity))
            .foregroundStyle(Color.blue.gradient)
        }
    }
}

#Preview {
    DailySalesCharsView(salesViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain") {
    PlainDataDailySalesCharsView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
