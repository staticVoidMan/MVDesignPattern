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

private let environment: APIEnvironment = .test

enum APIEnvironment {
    case test
    case prod
    
    static var current: APIEnvironment {
        environment
    }
}

enum APIEndpoints {
    case base
    case listOrders
    case createOrder
    case updateOrder(OrderID)
    case deleteOrder(OrderID)
    
    var path: String {
        switch self {
        case .base:
            switch APIEnvironment.current {
            case .test:
                return "https://island-bramble.glitch.me"
            case .prod:
                return "https://island-bramble.glitch.me"
            }
        case .listOrders:
            return "test/orders"
        case .createOrder:
            return "test/new-order"
        case let .updateOrder(id):
            return "test/orders/\(id)"
        case let .deleteOrder(id):
            return "test/orders/\(id)"
        }
    }
}
