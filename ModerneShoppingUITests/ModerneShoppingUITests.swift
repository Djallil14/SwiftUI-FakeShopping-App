//
//  ModerneShoppingUITests.swift
//  ModerneShoppingUITests
//
//  Created by Djallil Elkebir on 2021-09-10.
//

import XCTest

class ModerneShoppingUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testBasicUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual(app.tabBars.buttons.count, 3)

    }
    func testCartBadgeAddingItemToCart(){
        let app = XCUIApplication()
        app.launch()
        let addCartButton = app.buttons["Add to cart1"]
        let cartNavigationTrailingItem = app.navigationBars.buttons["trailingNavigationBarItem"]
        XCTAssert(cartNavigationTrailingItem.exists)
        XCTAssertTrue(addCartButton.waitForExistence(timeout: 2))
        addCartButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
