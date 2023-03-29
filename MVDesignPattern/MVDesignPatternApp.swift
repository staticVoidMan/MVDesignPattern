//
//  MVDesignPatternApp.swift
//  MVDesignPattern
//
//  Created by Amin Siddiqui on 29/03/23.
//

import SwiftUI

@main
struct MVDesignPatternApp: App {
    
    @StateObject var productListViewModel = ProductListViewModel(provider: ProductAPIProvider())
    
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(productListViewModel)
        }
    }
}
