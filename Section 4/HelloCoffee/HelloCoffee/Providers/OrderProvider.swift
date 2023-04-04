//
//  OrderProvider.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

protocol OrderProvider {
    func getOrders() async throws -> [Order]
    func placeOrder(_ order: Order) async throws -> Order
}

enum NetworkError: Error {
    case badURL
    case badRequest
}

struct OrderAPIProvider: OrderProvider {
    
    func getOrders() async throws -> [Order] {
        guard let baseURL = URL(string: APIEndpoints.base.path),
              let url = URL(string: APIEndpoints.listOrders.path, relativeTo: baseURL)
        else { throw NetworkError.badURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
        else { throw NetworkError.badRequest }
        
        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
    
    func placeOrder(_ order: Order) async throws -> Order {
        guard let baseURL = URL(string: APIEndpoints.base.path),
              let url = URL(string: APIEndpoints.createOrder.path, relativeTo: baseURL)
        else { throw NetworkError.badURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
        else { throw NetworkError.badRequest }
        
        let newOrder = try JSONDecoder().decode(Order.self, from: data)
        return newOrder
    }
}
