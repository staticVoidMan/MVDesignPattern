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
                    .font(.headline)
                    .padding(.bottom, 1)
                HStack {
                    Text(order.coffeeName)
                    Text("(\(order.size.rawValue))")
                }
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
