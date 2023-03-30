//
//  Order.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

import Foundation

struct Order: Codable {
    let id: Int
    let name: String
    let coffeeName: String
    let total: Double
    let size: String
}
