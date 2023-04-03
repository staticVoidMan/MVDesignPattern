//
//  PlaceOrderView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 03/04/23.
//

import SwiftUI

struct PlaceOrderView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    var body: some View {
        Form {
            TextField("Customer Name", text: $name)
            TextField("Coffee Name", text: $coffeeName)
            TextField("Price", text: $price)
            
            Picker("Coffee Size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue)
                        .tag(size)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Place Order") {
                print(#function)
            }
            .placement(.center)
        }
    }
}

struct PlaceOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrderView()
    }
}
