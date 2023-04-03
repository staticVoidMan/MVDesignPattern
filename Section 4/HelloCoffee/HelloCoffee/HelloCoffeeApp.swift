//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
    
    @StateObject
    var model = OrderListModel(provider: OrderAPIProvider())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
