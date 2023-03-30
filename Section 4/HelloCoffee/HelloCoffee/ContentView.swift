//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject
    private var model: OrderListModel
    
    var body: some View {
        List(model.orders) { order in
            OrderCellView(order: order)
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
                OrderListModel(
                    provider: OrderListAPIProvider()
                )
            )
    }
}
