//
//  ProductListViewModel.swift
//  MVDesignPattern
//
//  Created by Amin Siddiqui on 29/03/23.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    
    @Published
    var products: [ProductViewModel] = []
    
    private let provider: ProductProvider
    
    init(provider: ProductProvider) {
        self.provider = provider
    }
    
    func getProducts() async {
        do {
            products = try await provider.getProducts().map(ProductViewModel.init(product:))
        } catch {
            print(error)
        }
    }
}

struct ProductViewModel: Identifiable {
    
    private let product: Product
    
    var id: Int {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    init(product: Product) {
        self.product = product
    }
}
