//
//  AcutionDTOTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 20.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import carz4life

class BiddingDTOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_bidding_initialization() {
        //Given
        let userIdValue = "testId"
        let auctionIdValue = "testAuctionId"
        let newPriceValue = Float(42)
        
        UserManager.shardedInstance.user = User(id: userIdValue, email: "testEmail")
        
        //When
        let bidding = Bidding(auctionId: auctionIdValue, newPrice: newPriceValue)
        
        //Then
        XCTAssertEqual(bidding.auctionId, "testAuctionId")
        XCTAssertEqual(bidding.userId, "testId")
        XCTAssertEqual(bidding.newPrice, newPriceValue)
    }
    
    func test_bidding_toJSON() {
        //Given
        let userIdValue = "testId"
        let auctionIdValue = "testAuctionId"
        let newPriceValue = Float(42)
        
        UserManager.shardedInstance.user = User(id: userIdValue, email: "testEmail")
        
        let dictExpected = ["auction_id" : auctionIdValue, "user_id" : userIdValue, "newPrice" : newPriceValue] as [String : Any]
        
        let bidding = Bidding(auctionId: auctionIdValue, newPrice: newPriceValue)
        
        //When
        let result = Mapper().toJSON(bidding)
        
        
        //Then
        for element in dictExpected {
            guard let resultValueForKey = result[element.key] as? Float else {
                guard let resultValueForKey = result[element.key] as? String else {
                    XCTAssertTrue(false)
                    return
                }
                XCTAssertEqual(resultValueForKey, element.value as! String)
                return
            }
            XCTAssertEqual(resultValueForKey, element.value as! Float)
        }
    }
    
}
