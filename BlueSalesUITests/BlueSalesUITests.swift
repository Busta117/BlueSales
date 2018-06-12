//
//  BlueSalesUITests.swift
//  BlueSalesUITests
//
//  Created by Santiago Bustamante on 6/9/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import XCTest

class BlueSalesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchResults() {
        
        let app = XCUIApplication()
        app.searchFields["Search Product"].tap()
        app.searchFields["Search Product"].typeText("Apple\n")
        let table = app.tables.containing(.table, identifier: "tableView")
        var firstCell = table.cells.element(boundBy: 0)
        
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: firstCell, handler: nil)
        XCTWaiter(delegate: self).wait(for: [myExpectation], timeout: 3)
        
        XCTAssertTrue(table.cells.count > 0)
        firstCell = table.cells.element(boundBy: 0)
        firstCell.tap()

    }
    
    func testDetailView() {
        
        testSearchResults()
        
        let app = XCUIApplication()
        
        let title = app.navigationBars["Detail"]
        
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: title , handler: nil)
        XCTWaiter(delegate: self).wait(for: [myExpectation], timeout: 3)
        
        XCTAssertTrue(title.exists, "Should be on the detail screen")
        
    }
    
}
