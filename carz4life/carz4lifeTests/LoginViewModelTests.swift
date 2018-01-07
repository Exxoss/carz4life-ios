//
//  LoginViewModelTests.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 01.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class LoginViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    let emailValid = "test@email.ch"
    let passwordValid = "testingPassword"
    
    let emailIncorrect = "testIncorrectEmail"
    let emailNotSet = ""
    let passwordNotSet = ""
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_rxDriverOutput_loginEnable() {
        //Given
        let loginViewModel = LoginViewModel()
        loginViewModel.email.value = emailValid
        loginViewModel.password.value = passwordValid
        
        //When
        let result = Variable(false)
        loginViewModel.loginEnabled.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(result.value)
    }
    func test_rxDriverOutput_loginDisable_noPassword() {
        //Given
        let loginViewModel = LoginViewModel()
        loginViewModel.email.value = emailValid
        loginViewModel.password.value = passwordNotSet
        
        //When
        let result = Variable(true)
        loginViewModel.loginEnabled.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!result.value)
    }
    
    func test_rxDriverOutput_loginDisable_noEmail() {
        //Given
        let loginViewModel = LoginViewModel()
        loginViewModel.email.value = emailNotSet
        loginViewModel.password.value = passwordValid
        
        //When
        let result = Variable(true)
        loginViewModel.loginEnabled.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!result.value)
    }
    func test_rxDriverOutput_loginDisable_incorrectEmail() {
        //Given
        let loginViewModel = LoginViewModel()
        loginViewModel.email.value = emailIncorrect
        loginViewModel.password.value = passwordValid
        
        //When
        let result = Variable(true)
        loginViewModel.loginEnabled.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!result.value)
    }
    
    func test_rxDriverOutput_loginExecuting() {
        //Given
        let loginViewModel = LoginViewModel()
        loginViewModel.repository.inProcess.value = true
        
        //When
        let result = Variable(false)
        loginViewModel.loginExecuting.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(result.value)
    }
    
    func test_rxDriverOutput_errorMsg() {
        //Given
        let expectedOuput = "testResult"
        
        let loginViewModel = LoginViewModel()
        loginViewModel.repository.apiErrString.value = expectedOuput
        
        //When
        let result = Variable("")
        loginViewModel.errorMsg.drive(result).disposed(by: disposeBag)
        
        //Then
        XCTAssertEqual(result.value, expectedOuput, "errorMsg match with API err String")
    }
    
}
