//
//  DetailBookSalesView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI

struct DetailBookSalesView: View {
    enum TimeInterval: String, CaseIterable, Identifiable {
        case day = "日"
        case week = "週"
        case month = "月"
        
        var id: Self { self }
    }
    
    @ObservedObject var salesViewModel: SalesViewModel
    @State private var selectedTimeInterval = TimeInterval.day
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTimeInterval.animation()) {
                ForEach(TimeInterval.allCases) { interval in
                    Text(interval.rawValue)
                }
            } label: {
                Text("グラフの表示期間")
            }
            .pickerStyle(.segmented)
            
            Group {
                Text("過去90日間の売り上げは") +
                Text("\(salesViewModel.totalSales)冊").bold().foregroundStyle(Color.accentColor)
            }
            .padding(.vertical)
            
            Group {
                switch selectedTimeInterval {
                case .day:
                    DailySalesCharsView(salesViewModel: salesViewModel)
                case .week:
                    WeeklySalesChartsView(salesViewModel: salesViewModel)
                case .month:
                    MonthlySalesChartsView(salesViewModel: salesViewModel)
                }
            }
            .aspectRatio(0.8, contentMode: .fit)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: .preview)
}
