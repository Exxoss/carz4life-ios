//
//  SearchResultsViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 09/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class SearchResultsViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_rxDriverOutputs() {
        //Given
        let viewModel = SearchResultsViewModel()
        
        let auctionTest1 = Auction(id: "IdTest")
        let auctionTest2 = Auction(id: "IdTest")
        let auctionTest3 = Auction(id: "IdTest")
        let auctionTest4 = Auction(id: "IdTest")
        
        auctionTest1.auctionStatus.value = AuctionStatus.closed
        auctionTest2.auctionStatus.value = AuctionStatus.pending
        auctionTest3.auctionStatus.value = AuctionStatus.alive
        auctionTest4.auctionStatus.value = AuctionStatus.pending
        
        viewModel.repository.auctions.value = [auctionTest1, auctionTest2, auctionTest3, auctionTest4]
        
        let resultAuctions = Variable<[Auction]>([])
        let resultIsLoading = Variable(true)
        
        viewModel.auctionsDisplayed.drive(resultAuctions).disposed(by: disposeBag)
        viewModel.isLoadingData.drive(resultIsLoading).disposed(by: disposeBag)

        
        //When
        viewModel.repository.inProcess.value = false
        
        //Then
        XCTAssertEqual(resultAuctions.value[0].auctionStatus.value, AuctionStatus.pending)
        XCTAssertEqual(resultAuctions.value[1].auctionStatus.value, AuctionStatus.pending)
        XCTAssertEqual(resultAuctions.value[2].auctionStatus.value, AuctionStatus.alive)
        XCTAssertEqual(resultAuctions.value[3].auctionStatus.value, AuctionStatus.closed)
        
        XCTAssertEqual(resultIsLoading.value, false)
        
       
    }
}
