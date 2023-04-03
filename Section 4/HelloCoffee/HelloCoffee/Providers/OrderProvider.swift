//
//  OrderProvider.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

protocol OrderProvider {
    func getOrders() async throws -> [Order]
}

enum NetworkError: Error {
    case badURL
}

struct OrderAPIProvider: OrderProvider {
    
    func getOrders() async throws -> [Order] {
        guard let baseURL = URL(string: APIEndpoints.base.path),
              let url = URL(string: APIEndpoints.listOrders.path, relativeTo: baseURL)
        else { throw NetworkError.badURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
}
