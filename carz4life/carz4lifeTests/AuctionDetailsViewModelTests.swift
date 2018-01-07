//
//  AuctionDetailsViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 20.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

@testable import carz4life

class AuctionDetailsViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_auctionDetailsViewModel_outputs() {
        //Given
        let auction = Auction(id: "testId")
        let carProperties = CarProperties()
        
        UserManager.shardedInstance.user = User(id: "auctionWinnerId", email: "testEmail")
        
        carProperties.engine.value = 1000
        carProperties.hpPower.value = 500
        carProperties.fuel.value = "Petrol"
        carProperties.gear.value = "Automatic"
        carProperties.door.value = 2
        carProperties.seat.value = 2
        carProperties.light.value = "Xenon"
        carProperties.mileage.value = 0
        
        auction.title.value = "testTitle"
        auction.auctionStatus.value = AuctionStatus.alive
        auction.mark.value = "Audi"
        auction.model.value = "R8"
        auction.price.value = 135000
        auction.auctionWinnerId.value = "auctionWinnerId"
        auction.bidHistory.value = ["auctionWinnerId"]
        auction.description.value = "description"
        auction.carProperties = carProperties
        
        let viewModel = AuctionDetailsViewModel(auction: auction)
        
        let resultTitle = Variable("")
        let resultUserParticipateToTheAuction = Variable(false)
        let resultUserIsTheCurrentWinner = Variable(false)
        let resultShouldBidButtonBeEnable = Variable(true)
        let resultAuctionStatus = Variable(AuctionStatus.closed)
        let resultShouldTimerBeforeStatusChangeBeHidden = Variable(true)
        let resultCurrentPrice = Variable("")
        let resultNewPriceAfterBidding = Variable("")
        let resultShouldNewPriceAfterBiddingBeHidden = Variable(false)
        let resultMark = Variable("")
        let resultModel = Variable("")
        let resultDescription = Variable("")
        
        let resultEngine = Variable("")
        let resultHpPower = Variable("")
        let resultFuel = Variable("")
        let resultGear = Variable("")
        let resultDoor = Variable("")
        let resultSeat = Variable("")
        let resultLight = Variable("")
        let resultMileage = Variable("")
        
        let resultCountUsersParticipatedToTheAuction = Variable("")
        
        //When
        viewModel.title.drive(resultTitle).disposed(by: disposeBag)
        viewModel.userParticipateToTheAuction.drive(resultUserParticipateToTheAuction).disposed(by: disposeBag)
        viewModel.userIsTheCurrentWinner.drive(resultUserIsTheCurrentWinner).disposed(by: disposeBag)
        viewModel.shouldBidButtonBeEnable.drive(resultShouldBidButtonBeEnable).disposed(by: disposeBag)
        viewModel.auctionStatus.drive(resultAuctionStatus).disposed(by: disposeBag)
        viewModel.shouldTimerBeforeStatusChangeBeHidden.drive(resultShouldTimerBeforeStatusChangeBeHidden).disposed(by: disposeBag)
        viewModel.currentPrice.drive(resultCurrentPrice).disposed(by: disposeBag)
        viewModel.newPriceAfterBidding.drive(resultNewPriceAfterBidding).disposed(by: disposeBag)
        viewModel.shouldNewPriceAfterBiddingBeHidden.drive(resultShouldNewPriceAfterBiddingBeHidden).disposed(by: disposeBag)
        viewModel.mark.drive(resultMark).disposed(by: disposeBag)
        viewModel.model.drive(resultModel).disposed(by: disposeBag)
        viewModel.description.drive(resultDescription).disposed(by: disposeBag)
        
        viewModel.engine.drive(resultEngine).disposed(by: disposeBag)
        viewModel.hpPower.drive(resultHpPower).disposed(by: disposeBag)
        viewModel.fuel.drive(resultFuel).disposed(by: disposeBag)
        viewModel.gear.drive(resultGear).disposed(by: disposeBag)
        viewModel.door.drive(resultDoor).disposed(by: disposeBag)
        viewModel.seat.drive(resultSeat).disposed(by: disposeBag)
        viewModel.light.drive(resultLight).disposed(by: disposeBag)
        viewModel.mileage.drive(resultMileage).disposed(by: disposeBag)
        
        viewModel.countUsersParticipatedToTheAuction.drive(resultCountUsersParticipatedToTheAuction).disposed(by: disposeBag)
        
        
        //Then
        XCTAssertEqual(resultTitle.value, auction.title.value)
        XCTAssertEqual(resultUserParticipateToTheAuction.value, true)
        XCTAssertEqual(resultUserIsTheCurrentWinner.value, true)
        XCTAssertEqual(resultShouldBidButtonBeEnable.value, false)
        XCTAssertEqual(resultAuctionStatus.value, auction.auctionStatus.value)
        XCTAssertEqual(resultShouldTimerBeforeStatusChangeBeHidden.value, false)
        XCTAssertEqual(resultCurrentPrice.value, stringFromPrices(price: auction.price.value))
        XCTAssertEqual(resultNewPriceAfterBidding.value, stringFromPrices(price: getStepForPrice(currentPrice: auction.price.value) + auction.price.value))
        XCTAssertEqual(resultShouldNewPriceAfterBiddingBeHidden.value, false)
        XCTAssertEqual(resultMark.value, auction.mark.value)
        XCTAssertEqual(resultModel.value, auction.model.value)
        
        let stringFormatter = StringFormatterHelper()
        
        XCTAssertEqual(resultDescription.value, stringFormatter.descriptionStringFormatter(value: auction.description.value))
        
        XCTAssertEqual(resultEngine.value, stringFormatter.engineStringFormatter(cylinder: auction.carProperties.engine.value))
        XCTAssertEqual(resultHpPower.value, stringFormatter.hpPowerStringFormatter(hp: auction.carProperties.hpPower.value))
        XCTAssertEqual(resultFuel.value, stringFormatter.propertyStringFormatter(value: auction.carProperties.fuel.value))
        XCTAssertEqual(resultGear.value, stringFormatter.propertyStringFormatter(value: auction.carProperties.gear.value))
        XCTAssertEqual(resultDoor.value, stringFormatter.intPropertyStringFormatter(value: auction.carProperties.door.value))
        XCTAssertEqual(resultSeat.value, stringFormatter.intPropertyStringFormatter(value: auction.carProperties.seat.value))
        XCTAssertEqual(resultLight.value, stringFormatter.propertyStringFormatter(value: auction.carProperties.light.value))
        XCTAssertEqual(resultMileage.value, stringFormatter.mileageStringFormatter(km: auction.carProperties.mileage.value))
        
        XCTAssertEqual(resultCountUsersParticipatedToTheAuction.value, String(auction.bidHistory.value.count))
        
    }
    
}
