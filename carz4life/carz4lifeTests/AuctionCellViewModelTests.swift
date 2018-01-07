//
//  AuctionCellViewModel.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 09/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class AuctionCellViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_rxDriverOutput() {
        //Given
        let titleValue = "testTitle"
        let markValue = "testMark"
        let modelValue = "testModel"
        let priceValue = Float(8999)
        let statusValue = AuctionStatus.alive
        let timeBeforeOpeningValue = TimeInterval(1000)
        
        let auction = Auction(id: "testId")
        
        auction.auctionStatus.value = statusValue
        auction.mark.value = markValue
        auction.model.value = modelValue
        auction.title.value = titleValue
        auction.price.value = priceValue
        auction.timeBeforeOpening.value = timeBeforeOpeningValue
        
        let resultTitle = Variable("")
        let resultMark = Variable("")
        let resultModel = Variable("")
        let resultStatus = Variable(AuctionStatus.closed)
        let resultPrice = Variable("")
        let resultTimeBeforeOpening = Variable("")
        
        let viewModel = AuctionCellViewModel(auction: auction)
        
        //When
        viewModel.auctionStatus.drive(resultStatus).disposed(by: disposeBag)
        viewModel.mark.drive(resultMark).disposed(by: disposeBag)
        viewModel.model.drive(resultModel).disposed(by: disposeBag)
        viewModel.title.drive(resultTitle).disposed(by: disposeBag)
        viewModel.price.drive(resultPrice).disposed(by: disposeBag)
        viewModel.timeBeforeOpening.drive(resultTimeBeforeOpening).disposed(by: disposeBag)
        
        //Then
        XCTAssertEqual(resultTitle.value, titleValue)
        XCTAssertEqual(resultPrice.value, stringFromPrices(price: priceValue))
        XCTAssertEqual(resultMark.value, markValue)
        XCTAssertEqual(resultModel.value, modelValue)
        XCTAssertEqual(resultStatus.value, statusValue)
        XCTAssertEqual(resultTimeBeforeOpening.value, stringFromTimeInterval(interval: timeBeforeOpeningValue))
    }
}
