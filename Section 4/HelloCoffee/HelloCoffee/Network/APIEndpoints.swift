//
//  APIEndpoints.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

/*
 curl --location 'https://island-bramble.glitch.me/test/orders'; \
 curl --location 'https://island-bramble.glitch.me/test/new-order' \
 --header 'Content-Type: application/json' \
 --data '{
     "name": "John Doe",
     "coffeeName": "Hot Coffee",
     "total": 4.50,
     "size": "Medium"
 }'
 */

private let environment: Environment = .test

enum Environment {
    case test
    case prod
    
    static var current: Environment {
        environment
    }
}

enum APIEndpoints {
    case base
    case listOrders
    
    var path: String {
        switch self {
        case .base:
            switch Environment.current {
            case .test:
                return "https://island-bramble.glitch.me"
            case .prod:
                return "https://island-bramble.glitch.me"
            }
        case .listOrders:
            return "test/orders"
        }
    }
}
