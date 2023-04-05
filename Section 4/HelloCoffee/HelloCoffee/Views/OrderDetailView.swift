//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 05/04/23.
//

import SwiftUI

struct OrderDetailView: View {
    
    let order: Order
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(order.coffeeName)
                    .font(.title)
                
                Text(order.size.rawValue)
                    .opacity(0.5)
                
                Text(order.total as NSNumber, formatter: NumberFormatter.currencyFormat)
                
                HStack {
                    Spacer()
                    Button("Delete", role: .destructive) {
                        print(#function)
                    }
                    .padding()
                    Button("Edit") {
                        isEditing = true
                    }
                    .padding()
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            PlaceOrderView()
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: PreviewData.smallHotCoffee)
    }
}
