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
    
    @State private var isPlacingOrder: Bool = false
    
    var body: some View {
        ConditionalView(
            isOrderListEmpty,
            then: {
                Text("No orders found!")
                    .accessibilityIdentifier("noOrdersText")
            },
            else: {
                List {
                    ForEach(model.orders, id: \.hashValue) { order in
                        NavigationLink(value: order) {
                            OrderCellView(order: order)
                        }
                    }
                    .onDelete(perform: deleteOrder(at:))
                }
                .navigationDestination(for: Order.self) { order in
                    if let orderId = order.id {
                        OrderDetailView(orderID: orderId)
                    }
                }
                .accessibilityIdentifier("orderList")
            }
        )
        .sheet(isPresented: $isPlacingOrder) {
            PlaceOrderView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Place Order") {
                    isPlacingOrder = true
                }
                .accessibilityIdentifier("placeOrderButton")
            }
        }
        .embedForNavigation()
        .task {
            await model.getOrders()
        }
    }
    
    private func deleteOrder(at indices: IndexSet) {
        indices.forEach { index in
            guard let id = model.orders[index].id else { return }
            Task {
                await model.deleteOrder(id)
            }
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
