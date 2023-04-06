//
//  APIEndpoints.swift
//  HelloCoffee
//
//  Created by Amin Siddiqui on 30/03/23.
//

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
                return "https://topaz-azure-kiwi.glitch.me"
            case .prod:
                return "https://tame-citrine-carpet.glitch.me"
            }
        case .listOrders:
            return "order/all"
        case .createOrder:
            return "order/create"
        case let .updateOrder(id):
            return "order/\(id)"
        case let .deleteOrder(id):
            return "order/\(id)"
        }
    }
}
