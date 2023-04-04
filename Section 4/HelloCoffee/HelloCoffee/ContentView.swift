//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject
    private var model: OrderModel
    
    var isOrderListEmpty: Binding<Bool> {
        Binding<Bool>(
            get: { model.orders.isEmpty },
            set: { _, _ in }
        )
    }
    
    var body: some View {
        ConditionalView(
            isOrderListEmpty,
            then: {
                Text("No orders found!")
                    .accessibilityIdentifier("noOrdersText")
            },
            else: {
                List(model.orders) { order in
                    OrderCellView(order: order)
                }
            }
        }
        .task {
            await model.getOrders()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                OrderModel(
                    provider: OrderAPIProvider()
                )
            )
    }
}
