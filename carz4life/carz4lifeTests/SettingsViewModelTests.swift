//
//  SettingsViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 09/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class SettingsViewModelTests: XCTestCase {
    
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
        let emailValue = "testEmail"
        
        UserManager.shardedInstance.user.email.value = emailValue
        
        let viewModel = SettingsViewModel()
        let resultEmail = Variable("")
        
        //When
        viewModel.userEmail.drive(resultEmail).disposed(by: disposeBag)
        
        //Then
        XCTAssertEqual(resultEmail.value, emailValue)
    }
    
}
