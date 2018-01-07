//
//  carz4lifeTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest

@testable import carz4life

class HelpersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_isValidEmail_valid() {
        //Given
        
        //When
        let result = isValidEmail(testStr: "test@email.ch")
        
        //Then
        XCTAssertTrue(result)
    }
    
    func test_isValidEmail_notValid() {
        //Given
        
        //When
        let result = isValidEmail(testStr: "test")
        
        //Then
        XCTAssertTrue(!result)
    }
    
    func test_colorHelper_returnUIColor() {
        //Given
        
        //When
        let testColor = ColorHelper.sharedInstance.primary
        
        //Then
        XCTAssertTrue((testColor as Any) is UIColor)
    }
    
    
    func test_fomatingHelper_stringFromPrice() {
        //Given
        let stringExpected = "CHF 35’000.00"
        
        //When
        let result = stringFromPrices(price: 35000)
        
        //Then
        XCTAssertEqual(result, stringExpected)
    }
    
    func test_formatingHelper_dateFromISOString() {
        //Given
        let string = "2017-12-25T14:13:34.667Z"
        
        //When
        let result = dateFromString(dateString: string)
        
        //Then
        XCTAssertTrue((result as Any) is Date)
    }
    
    func test_formatingHelper_timeIntervaleRemainingFromDate() {
        //Given
        
        //When
        let result = timeIntervalRemainingFromDate(date: Date())
        
        //Then
        XCTAssertTrue((result as Any) is TimeInterval)
    }
    
    func test_mappingHelper_updateAuctionObjValuesFromDictionary() {
        //Given
        let dict = [
            "auction_status" : 0,
            "end_auction_date" : "2017-12-25T14:13:34.667Z",
            "mark" : "Subaru",
            "model" : "Impreza",
            "price" : Float(89999),
            "start_auction_date" : "2017-12-25T14:13:34.667Z",
            "title" : "testTitle",
            "auction_winner_id" : "userIdTest",
            "image_urls" : ["url1", "url2"],
            "description" : "descriptionTest",
            "car_properties" : [
                "engine" : 1000,
                "fuel" : "fuelTest",
                "mileage" : 1000,
                "gear" : "gearTest",
                "seat" : 5,
                "door" : 5,
                "hp_power" : 1000,
                "light" : "Xenon"
            ]
        ] as [String : Any]
        
        var auction = Auction(id: "idTest")
        
        //When
        MappingHelper().updateAuctionObjValuesFromDictionary(auction: &auction, dict: dict as NSDictionary)
        
        //Then
        XCTAssertEqual(auction.auctionStatus.value, AuctionStatus(rawValue: (dict["auction_status"] as! Int)))
        XCTAssertEqual(auction.auctionWinnerId.value, dict["auction_winner_id"] as! String)
        XCTAssertEqual(auction.endAuctionDate.value, dateFromString(dateString: (dict["end_auction_date"] as! String)))
        XCTAssertEqual(auction.startAuctionDate.value, dateFromString(dateString: (dict["start_auction_date"] as! String)))
        XCTAssertEqual(auction.mark.value, dict["mark"] as! String)
        XCTAssertEqual(auction.model.value, dict["model"] as! String)
        XCTAssertEqual(auction.price.value, dict["price"] as! Float)
        XCTAssertEqual(auction.title.value, dict["title"] as! String)
        XCTAssertEqual(auction.imagesURL.value, dict["image_urls"] as! [String])
        XCTAssertEqual(auction.description.value, dict["description"] as! String)
        XCTAssertEqual(auction.carProperties.engine.value, (dict["car_properties"] as! NSDictionary)["engine"] as! Int)
        XCTAssertEqual(auction.carProperties.fuel.value, (dict["car_properties"] as! NSDictionary)["fuel"] as! String)
        XCTAssertEqual(auction.carProperties.mileage.value, (dict["car_properties"] as! NSDictionary)["mileage"] as! Int)
        XCTAssertEqual(auction.carProperties.gear.value, (dict["car_properties"] as! NSDictionary)["gear"] as! String)
        XCTAssertEqual(auction.carProperties.seat.value, (dict["car_properties"] as! NSDictionary)["seat"] as! Int)
        XCTAssertEqual(auction.carProperties.door.value, (dict["car_properties"] as! NSDictionary)["door"] as! Int)
        XCTAssertEqual(auction.carProperties.hpPower.value, (dict["car_properties"] as! NSDictionary)["hp_power"] as! Int)
        XCTAssertEqual(auction.carProperties.light.value, (dict["car_properties"] as! NSDictionary)["light"] as! String)
    }
    
    func test_searchHelper_filterAuctions() {
        //Given
        let markValue = "markValue"
        let modelValue = "modelValue"
        let titleValue = "titleValue"
        let titlePartialValue = "title"
        let differentValue = "differentValue"
        
        let auction1 = Auction(id: "idTest1")
        let auction2 = Auction(id: "idTest2")
        let auction3 = Auction(id: "idTest4")
        let auction4 = Auction(id: "idTest3")
        
        auction1.mark.value = markValue
        auction1.model.value = differentValue
        auction1.title.value = differentValue
        
        auction2.mark.value = markValue
        auction2.model.value = modelValue
        auction2.title.value = differentValue
        
        auction3.mark.value = differentValue
        auction3.model.value = differentValue
        auction3.title.value = titleValue
        
        auction4.mark.value = markValue
        auction4.model.value = differentValue
        auction4.title.value = titleValue
        
        let auctions = [auction1, auction2, auction3, auction4]
        
        //When
        let resultMarkFiltered = filterAuctions(auctionData: auctions, query: markValue) //1 & 2 & 4
        let resultMarkAndModelFiltered = filterAuctions(auctionData: auctions, query: markValue + " " + modelValue)// 2
        let resultTitleFiltered = filterAuctions(auctionData: auctions, query: titleValue)//3 & 4
        let resultTitlePartialAndMarkFiltered = filterAuctions(auctionData: auctions, query: markValue + " " + titlePartialValue)//4
        
        //Then
        XCTAssertTrue(resultMarkFiltered.contains(where: {$0.mark.value == markValue}))
        XCTAssertEqual(resultMarkFiltered.count, 3)
        
        XCTAssertTrue(resultMarkAndModelFiltered.contains(where: {$0.mark.value == markValue && $0.model.value == modelValue}))
        XCTAssertEqual(resultMarkAndModelFiltered.count, 1)
        
        XCTAssertTrue(resultTitleFiltered.contains(where: {$0.title.value == titleValue}))
        XCTAssertEqual(resultTitleFiltered.count, 2)
        
        XCTAssertTrue(resultTitlePartialAndMarkFiltered.contains(where: {$0.title.value == titleValue && $0.mark.value == markValue}))
        XCTAssertEqual(resultTitlePartialAndMarkFiltered.count, 1)
        
    }
    
    func test_auctionHelper_getStepForPrice() {
        XCTAssertTrue((getStepForPrice(currentPrice: 42) as Any) is Float)
    }
}
