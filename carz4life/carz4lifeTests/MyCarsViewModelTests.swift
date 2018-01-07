//
//  MyCarsViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 28/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class MyCarsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_MyCarsViewModel_Outputs() {
        //Given
        let viewModel = MyCarsViewModel()
        let disposeBag = DisposeBag()
        
        let currentUserId = "userId"
        let differentId = "differentId"
        
        UserManager.shardedInstance.user = User(id: currentUserId, email: "email@test.fr")
        
        let auction1 = Auction(id: "idTest1")
        let auction2 = Auction(id: "idTest2")
        let auction3 = Auction(id: "idTest3")
        
        auction1.auctionWinnerId.value = currentUserId
        auction2.auctionWinnerId.value = currentUserId
        auction3.auctionWinnerId.value = differentId
        
        auction1.auctionStatus.value = AuctionStatus.alive
        auction2.auctionStatus.value = AuctionStatus.closed
        auction3.auctionStatus.value = AuctionStatus.closed
        
        viewModel.repository.auctions.value = [auction1, auction2, auction3]
        viewModel.repository.inProcess.value = false
        
        let resultAuctions = Variable<[Auction]>([])
        let resultIsLoadingData = Variable(true)
        
        //When
        viewModel.auctions.drive(resultAuctions).disposed(by: disposeBag)
        viewModel.isLoadingData.drive(resultIsLoadingData).disposed(by: disposeBag)
        
        viewModel.selectAuctionCommand(index: 0)
        viewModel.selectItemCommand(index: 0)
        
        //Then
        XCTAssertFalse(resultIsLoadingData.value)
        
        XCTAssertEqual(resultAuctions.value.count, 1)
        XCTAssertEqual(resultAuctions.value[0].id, "idTest2")
        
        XCTAssertEqual(viewModel.selectedItem.value?.id, "idTest2")
        XCTAssertEqual(viewModel.selectedAuction.value?.id, "idTest2")
    }
    
}
