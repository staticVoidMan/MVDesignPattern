//
//  Order.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

typealias OrderID = Int

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable {
    let id: OrderID?
    let name: String
    let coffeeName: String
    let total: Double
    let size: CoffeeSize
}

extension Order: Identifiable, Hashable {}
