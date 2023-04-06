//
//  HelloCoffeeE2ETests.swift
//  HelloCoffeeE2ETests
//
//  Created by Amin Siddiqui on 03/04/23.
//

import XCTest

final class HelloCoffeeE2ETests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    func testShouldShow_Message_WhenNoOrder() {
        XCTAssertEqual(app.staticTexts["noOrdersText"].label, "No orders found!")
    }
    
    func testShouldShow_NewlyCreatedOrder() {
        app.buttons["placeOrderButton"].tap()
        
        let customerNameField = app.textFields["customerName"]
        let coffeeNameField = app.textFields["coffeeName"]
        let priceField = app.textFields["coffeePrice"]
        
        customerNameField.tap()
        customerNameField.typeText("John")
        
        coffeeNameField.tap()
        coffeeNameField.typeText("Some Coffee")
        
        priceField.tap()
        priceField.typeText("99.9")
        
        app.buttons["orderCoffee"].tap()
        
        XCTAssertEqual(app.staticTexts["title"].label, "John")
        XCTAssertEqual(app.staticTexts["subtitle"].label, "Some Coffee (Medium)")
        XCTAssertEqual(app.staticTexts["price"].label, "$99.90")
        
        addTeardownBlock {
            let url = URL(string: "https://topaz-azure-kiwi.glitch.me/order/all")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let _ = try await URLSession.shared.data(for: request)
        }
    }
    
    func testShouldDelete_ExistingOrder() {
        app.buttons["placeOrderButton"].tap()
        
        let customerNameField = app.textFields["customerName"]
        let coffeeNameField = app.textFields["coffeeName"]
        let priceField = app.textFields["coffeePrice"]
        
        customerNameField.tap()
        customerNameField.typeText("John")
        
        coffeeNameField.tap()
        coffeeNameField.typeText("Some Coffee")
        
        priceField.tap()
        priceField.typeText("99.9")
        
        app.buttons["orderCoffee"].tap()
        
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery
            .cells
            .children(matching: .other)
            .element(boundBy: 1)
            .children(matching: .other)
            .element
        
        XCTAssertEqual(cell.waitForExistence(timeout: 1), true)
        
        cell.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        let list = app.collectionViews["orderList"]
        XCTAssertEqual(list.cells.count, 0)
        
        addTeardownBlock {
            let url = URL(string: "https://topaz-azure-kiwi.glitch.me/order/all")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let _ = try await URLSession.shared.data(for: request)
        }
    }
}
