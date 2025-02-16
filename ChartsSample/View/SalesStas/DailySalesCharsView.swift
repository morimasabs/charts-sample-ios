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

    var body: some View {
        Chart(salesViewModel.salesByDay, id: \.day) { saleData in
            BarMark(x: .value("Day", saleData.day, unit: .day),
                    y: .value("Sales", saleData.sales))
            .foregroundStyle(Color.blue.gradient)
        }
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
