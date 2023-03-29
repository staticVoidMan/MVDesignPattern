//
//  ProductProvider.swift
//  MVDesignPattern
//
//  Created by Amin Siddiqui on 29/03/23.
//

protocol ProductProvider {
    func getProducts() async throws -> [Product]
}
