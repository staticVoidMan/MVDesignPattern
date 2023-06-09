//
//  ProductListView.swift
//  MVDesignPattern
//
//  Created by Amin Siddiqui on 29/03/23.
//

import SwiftUI

struct ProductListView: View {
    
    @EnvironmentObject
    private var viewModel: ProductListViewModel
    
    var body: some View {
        List(viewModel.products) { product in
            Text(product.title)
        }
        .task {
            await viewModel.getProducts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
            .environmentObject(
                ProductListViewModel(
                    provider: ProductAPIProvider()
                )
            )
    }
}
