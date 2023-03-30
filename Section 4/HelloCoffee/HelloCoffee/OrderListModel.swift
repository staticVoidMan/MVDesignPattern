//
//  OrderListModel.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

class OrderListModel: ObservableObject {
    
    let provider: OrderListProvider
    
    @Published
    private(set) var orders: [Order] = []
    
    init(provider: OrderListProvider) {
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
