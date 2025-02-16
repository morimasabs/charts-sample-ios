//
//  SimpleBookSalesView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI

struct SimpleBookSalesView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        VStack {
            if let changedBookSales = changedBookSales() {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: isPositiveChange ? "arrow.up.right" : "arrow.down.right")
                        .bold()
                        .foregroundStyle(isPositiveChange ? .green : .red)
                    Text("過去90日間で書籍の売上は") +
                    Text(changedBookSales).bold()
                }
            }
            WeeklySalesChartsView(salesViewModel: salesViewModel)
                .frame(height: 100)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
        }
    }
    
    func changedBookSales() -> String? {
        let percentage = percentage
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: percentage)) else {
            return nil
        }
        
        let changedDescription = percentage < 0 ? "減少しました" : "増加しました"
        
        return formattedPercentage + changedDescription
    }
    
    var percentage: Double {
        Double(salesViewModel.totalSales) / Double(salesViewModel.lastTotalSales) - 1
    }
    
    var isPositiveChange: Bool {
        percentage > 0
    }
}

#Preview("positive") {
    SimpleBookSalesView(salesViewModel: .preview)
        .padding()
}

#Preview("negative") {
    let decresedVM = SalesViewModel.preview
    decresedVM.lastTotalSales = 24500
    
    return SimpleBookSalesView(salesViewModel: decresedVM)
        .padding()
}
