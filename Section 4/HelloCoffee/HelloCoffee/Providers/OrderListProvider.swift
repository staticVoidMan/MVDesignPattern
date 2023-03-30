//
//  OrderListProvider.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

protocol OrderListProvider {
    func getOrders() async throws -> [Order]
}

enum NetworkError: Error {
    case badURL
}

struct OrderListAPIProvider: OrderListProvider {
    
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: "https://island-bramble.glitch.me/test/orders")
        else { throw NetworkError.badURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
}
