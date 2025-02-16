//
//  DetailBookSalesView.swift
//  ChartsSample
//
//  Created by Masahito Mori on 2025/02/16.
//

import SwiftUI

struct DetailBookSalesView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailBookSalesView(salesViewModel: .preview)
}
