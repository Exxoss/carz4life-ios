//
//  ModelsTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 01.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class ModelsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_user() {
        //Given
        
        //When
        let user = User(id: "testid", email: "test@email.ch")
        
        //Then
        XCTAssertTrue((user.id as Any) is String)
        XCTAssertTrue((user.email as Any) is Variable<String>)
    }
    
    func test_auction() {
        //Given
        let expectedId = "testid"
        
        //When
        let auction = Auction(id: expectedId)
        
        //Then
        XCTAssertTrue((auction.id as Any) is String)
        XCTAssertEqual(auction.id, expectedId)
        XCTAssertTrue((auction.title as Any) is Variable<String>)
        XCTAssertTrue((auction.auctionWinnerId as Any) is Variable<String>)
        XCTAssertTrue((auction.description as Any) is Variable<String>)
        XCTAssertTrue((auction.mark as Any) is Variable<String>)
        XCTAssertTrue((auction.model as Any) is Variable<String>)
        XCTAssertTrue((auction.carProperties as Any) is CarProperties)
        XCTAssertTrue((auction.endAuctionDate as Any) is Variable<Date>)
        XCTAssertTrue((auction.startAuctionDate as Any) is Variable<Date>)
        XCTAssertTrue((auction.imagesURL as Any) is Variable<[String]>)
        XCTAssertTrue((auction.price as Any) is Variable<Float>)
        XCTAssertTrue((auction.timeBeforeClosing as Any) is Variable<TimeInterval>)
        XCTAssertTrue((auction.timeBeforeOpening as Any) is Variable<TimeInterval>)
    }
    func test_auctionStatus() {
        //Given
        let pendingStatus = AuctionStatus.pending
        let aliveStatus = AuctionStatus.alive
        let closedStatus = AuctionStatus.closed
        
        //When
        let expectedPendingStatus = AuctionStatus(rawValue: 0)
        let expectedAliveStatus = AuctionStatus(rawValue: 1)
        let expectedClosedStatus = AuctionStatus(rawValue: 2)
        
        //Then
        XCTAssertEqual(expectedPendingStatus, pendingStatus)
        XCTAssertEqual(expectedAliveStatus, aliveStatus)
        XCTAssertEqual(expectedClosedStatus, closedStatus)
    }
    
    func test_carProperties() {
        //Given
        
        //When
        let carProperties = CarProperties()
        
        //Then
        XCTAssertTrue((carProperties.door as Any) is Variable<Int>)
        XCTAssertTrue((carProperties.engine as Any) is Variable<Int>)
        XCTAssertTrue((carProperties.hpPower as Any) is Variable<Int>)
        XCTAssertTrue((carProperties.mileage as Any) is Variable<Int>)
        XCTAssertTrue((carProperties.seat as Any) is Variable<Int>)
        XCTAssertTrue((carProperties.fuel as Any) is Variable<String>)
        XCTAssertTrue((carProperties.gear as Any) is Variable<String>)
        XCTAssertTrue((carProperties.light as Any) is Variable<String>)
    }
    
    func test_markLogoEnum_return() {
        //Given
        
        //When
        let realMark = setupLogoFromMark(mark: "Audi")
        let defaultResult = setupLogoFromMark(mark: "notAMark")
        
        //Then
        XCTAssertEqual(realMark, MarkLogoEnum.audi)
        XCTAssertEqual(defaultResult, MarkLogoEnum.defaultLogo)
    }
    
}
