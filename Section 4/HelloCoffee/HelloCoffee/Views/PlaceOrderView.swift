//
//  PlaceOrderView.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 03/04/23.
//

import SwiftUI

struct PlaceOrderViewErrors {
    
    var customerName: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct PlaceOrderView: View {
    
    let order: Order?
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var model: OrderModel
    
    private var isFormValid: Bool {
        errors = .init()
        
        if name.isEmpty {
            errors.customerName = "Customer name should not be empty"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee name should not be empty"
        }
        
        errors.price = {
            if price.isEmpty {
                return "Price should not be empty"
            } else if let price = Double(price), price < 1 {
                return "Price should be > 0"
            } else {
                return ""
            }
        }()
        
        return errors.customerName.isEmpty
        && errors.coffeeName.isEmpty
        && errors.price.isEmpty
    }
    
    @State private var errors: PlaceOrderViewErrors = .init()
    
    var isUpdate: Bool { order != nil }
    
    init(order: Order? = nil) {
        self.order = order
    }
    
    var body: some View {
        Form {
            TextField("Customer Name", text: $name)
                .accessibilityIdentifier("customerName")
            Text(errors.customerName)
                .opacity(0.75)
                .hidden(errors.customerName.isEmpty)
            
            TextField("Coffee Name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            Text(errors.coffeeName)
                .opacity(0.75)
                .hidden(errors.coffeeName.isEmpty)
            
            TextField("Price", text: $price)
                .keyboardType(.decimalPad)
                .accessibilityIdentifier("coffeePrice")
            Text(errors.price)
                .opacity(0.75)
                .hidden(errors.price.isEmpty)
            
            Picker("Coffee Size", selection: $coffeeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue)
                        .tag(size)
                }
            }
            .pickerStyle(.segmented)
            
            Button(isUpdate ? "Update" : "Order") {
                if isFormValid {
                    let order = Order(
                        id: order?.id,
                        name: name,
                        coffeeName: coffeeName,
                        total: Double(price) ?? 0,
                        size: coffeeSize
                    )
                    Task {
                        if await model.placeOrUpdateOrder(order) {
                            dismiss()
                        }
                    }
                }
            }
            .placement(.center)
            .accessibilityIdentifier("orderCoffee")
        }
        .embedForNavigation(title: isUpdate ? "Your Coffee" : "Add Coffee")
        .onAppear {
            if let order {
                name = order.name
                coffeeName = order.coffeeName
                price = String(order.total)
                coffeeSize = order.size
            }
        }
    }
}

struct PlaceOrderView_Previews: PreviewProvider {
    
    static var model: OrderModel = OrderModel(provider: OrderAPIProvider())
    
    static var previews: some View {
        Group {
            PlaceOrderView()
                .environmentObject(model)
                .previewDisplayName("Create Order")
            
            PlaceOrderView(order: PreviewData.smallHotCoffee)
                .environmentObject(model)
                .previewDisplayName("Update Order")
        }
    }
}
