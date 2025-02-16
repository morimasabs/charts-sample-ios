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
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleData in
            BarMark(x: .value("Week", saleData.day, unit: .weekOfYear),
                    y: .value("Sales", saleData.sales))
            // MARK: 集計してから渡すことで、1つの棒グラフ単位グラデーションをつけることができる
            .foregroundStyle(Color.blue.gradient)
        }
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
