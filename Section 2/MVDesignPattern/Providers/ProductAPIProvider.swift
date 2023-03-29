//
//  ProductAPIProvider.swift
//  MVDesignPattern
//
//  Created by Amin Siddiqui on 29/03/23.
//

import Foundation

struct InvalidURLError: Error {}

struct ProductAPIProvider: ProductProvider {
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products")
        else { throw InvalidURLError() }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    }
}
