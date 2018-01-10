//
//  carz4lifeUITests.swift
//  carz4lifeUITests
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest

class carz4lifeUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginPageAppear () {
        app.launch()
        if !app.otherElements["loginView"].exists {
            app.tabBars.buttons["Settings"].tap()
            app.buttons["logoutButton"].tap()
        }
        XCTAssertTrue(app.otherElements["loginView"].exists)
    }
}
