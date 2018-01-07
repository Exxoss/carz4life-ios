//
//  MyCarsCellViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 28/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class MyCarsCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_MyCarsCellViewModel_ouputs() {
        //Given
        let disposeBag = DisposeBag()
        
        let auction = Auction(id: "idTest")
        let expectedTitle = "titleExample"
        let expectedMark = "MarkExemple"
        let expectedModel = "ModelExemple"
        
        auction.title.value = expectedTitle
        auction.mark.value = expectedMark
        auction.model.value = expectedModel
        
        let viewModel = MyCarsCellViewModel(auction: auction)
        
        let resultTitle = Variable("")
        let resultMark = Variable("")
        let resultModel = Variable("")
        
        //When
        viewModel.title.drive(resultTitle).disposed(by: disposeBag)
        viewModel.mark.drive(resultMark).disposed(by: disposeBag)
        viewModel.model.drive(resultModel).disposed(by: disposeBag)
        
        //Then
        XCTAssertEqual(resultTitle.value, expectedTitle)
        XCTAssertEqual(resultMark.value, expectedMark)
        XCTAssertEqual(resultModel.value, expectedModel)
    }
}
