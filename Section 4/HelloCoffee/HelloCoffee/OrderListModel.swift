//
//  OrderListModel.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

class OrderListModel: ObservableObject {
    
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
}
