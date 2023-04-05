//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 05/04/23.
//

import SwiftUI

struct OrderDetailView: View {
    
    let orderID: OrderID
    
    var order: Order? {
        model.getOrder(byId: orderID)
    }
    
    @EnvironmentObject private var model: OrderModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            if let order {
                VStack(alignment: .leading, spacing: 8) {
                    Text(order.coffeeName)
                        .font(.title)
                    
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    
                    Text(order.total as NSNumber, formatter: NumberFormatter.currencyFormat)
                    
                    HStack {
                        Spacer()
                        Button("Delete", role: .destructive) {
                            Task {
                                if await model.deleteOrder(orderID) {
                                    dismiss()
                                }
                            }
                        }
                        .padding()
                        Button("Edit") {
                            isEditing = true
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            PlaceOrderView(order: order)
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(orderID: 0)
    }
}
