//
//  DailySalesCharsView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI
import Charts

struct DailySalesCharsView: View {
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Day", sale.saleDate, unit: .day),
                    y: .value("Sales", sale.quantity))
            .foregroundStyle(Color.blue.gradient)
        }
    }
}

#Preview {
    DailySalesCharsView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
