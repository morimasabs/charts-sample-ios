//
//  ContentView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var salesViewModel = SalesViewModel.preview
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    DetailBookSalesView(salesViewModel: salesViewModel)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }
            }
            .navigationTitle("売上統計データ")
        }
    }
}

#Preview {
    ContentView()
}
