//
//  MonthlySalesChartsView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI
import Charts

struct MonthlySalesChartsView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.salesByMonth, id: \.day) {
            BarMark(
                x: .value("Month", $0.day, unit: .month),
                y: .value("Sales", $0.sales)
            )
            .foregroundStyle(.blue.gradient)
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                // MARK: 波線をつくることができる
                AxisGridLine(stroke: .init(dash: [10, 5]))
                AxisValueLabel()
            }
        }
    }
}

#Preview {
    MonthlySalesChartsView(salesViewModel: .preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
