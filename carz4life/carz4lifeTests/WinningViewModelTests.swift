//
//  WinningViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 28/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class WinningViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_WinningViewModel_Outputs() {
        //Given
        let winningViewModel = WinningViewModel(auction: Auction(id: "testId"))
        
        //When
        
        //Then
        XCTAssertTrue((winningViewModel as Any) is WinningViewModel)
    }
}
