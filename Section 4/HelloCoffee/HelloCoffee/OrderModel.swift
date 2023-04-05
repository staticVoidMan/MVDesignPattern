//
//  OrderModel.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

@MainActor
class OrderModel: ObservableObject {
    
    let provider: OrderProvider
    
    @Published
    private(set) var orders: [Order] = []
    
    init(provider: OrderProvider) {
        self.provider = provider
    }
    
    func getOrders() async {
        do {
            orders = try await provider.getOrders()
        } catch {
            print(error)
        }
    }
    
    func placeOrder(_ order: Order) async -> Bool {
        do {
            let newOrder = try await provider.placeOrder(order)
            orders.append(newOrder)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func updateOrder(_ order: Order) async -> Bool {
        guard let index = orders.firstIndex(of: order)
        else { return false }
        
        do {
            try await provider.updateOrder(order)
            orders[index] = order
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func deleteOrder(_ id: OrderID) async -> Bool {
        guard let index = orders.firstIndex(where: { $0.id == id })
        else { return true }
        
        do {
            try await provider.deleteOrder(id)
            orders.remove(at: index)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
