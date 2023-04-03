//
//  HelloCoffeeE2ETests.swift
//  HelloCoffeeE2ETests
//
//  Created by Amin Siddiqui on 03/04/23.
//

import XCTest

final class HelloCoffeeE2ETests: XCTestCase {
    
    func testShouldShow_Message_WhenNoOrder() {
        let app = XCUIApplication()
        continueAfterFailure = false
        
        app.launch()
        XCTAssertEqual(app.staticTexts["noOrdersText"].label, "No orders found!")
    }
}
