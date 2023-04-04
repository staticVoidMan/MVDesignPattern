//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import SwiftUI

struct OrderCellView: View {
    
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .accessibilityIdentifier("title")
                    .font(.headline)
                    .padding(.bottom, 1)
                
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("subtitle")
                    .opacity(0.5)
            }
            
            Spacer()
            
            Text(
                order.total as NSNumber,
                formatter: {
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    return formatter
                }()
            )
            .accessibilityIdentifier("price")
            .font(.title2)
        }
    }
}

struct OrderCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        OrderCellView(order: PreviewData.smallHotCoffee)
            .previewLayout(.sizeThatFits)
    }
}
