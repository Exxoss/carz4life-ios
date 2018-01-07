//
//  SignUpViewModelTest.swift
//  carz4lifeTests
//
//  Created by Arthur Quemard on 01.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import XCTest
import RxSwift

@testable import carz4life

class SignUpViewModelTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    let emailValid = "test@email.ch"
    let passwordValid = "testingPassword"
    
    let emailNotSet = ""
    let confirmNotSet = ""
    
    let passwordIncorrect = "pwd"
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_rxDriverOutput_incorrectEmail() {
        //Given
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.email.value = emailNotSet
        signUpViewModel.password.value = passwordValid
        signUpViewModel.confirm.value = signUpViewModel.password.value
        
        let resultEmail = Variable(true)
        let resultSignUp = Variable(true)
        
        //When
        signUpViewModel.emailIsValid.drive(resultEmail).disposed(by: disposeBag)
        signUpViewModel.signUpEnabled.drive(resultSignUp).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!resultEmail.value)
        XCTAssertTrue(!resultSignUp.value)
    }
    func test_rxDriverOutput_incorrectPassword() {
        //Given
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.email.value = emailValid
        signUpViewModel.password.value = passwordIncorrect
        signUpViewModel.confirm.value = signUpViewModel.password.value
        
        let resultPassword = Variable(true)
        let resultSignUp = Variable(true)
        
        //When
        signUpViewModel.passwordIsValid.drive(resultPassword).disposed(by: disposeBag)
        signUpViewModel.signUpEnabled.drive(resultSignUp).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!resultPassword.value)
        XCTAssertTrue(!resultSignUp.value)
    }
    func test_rxDriverOutput_incorrectConfirm() {
        //Given
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.email.value = emailValid
        signUpViewModel.password.value = passwordValid
        signUpViewModel.confirm.value = confirmNotSet
        
        let resultConfirm = Variable(true)
        let resultSignUp = Variable(true)
        
        //When
        signUpViewModel.confirmIsValid.drive(resultConfirm).disposed(by: disposeBag)
        signUpViewModel.signUpEnabled.drive(resultSignUp).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(!resultConfirm.value)
        XCTAssertTrue(!resultSignUp.value)
    }
    func test_rxDriverOutput_signUpEnable() {
        //Given
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.email.value = emailValid
        signUpViewModel.password.value = passwordValid
        signUpViewModel.confirm.value = signUpViewModel.password.value
        
        let resultEmail = Variable(false)
        let resultPassword = Variable(false)
        let resultConfirm = Variable(false)
        let resultSignUp = Variable(false)
        
        //When
        signUpViewModel.emailIsValid.drive(resultEmail).disposed(by: disposeBag)
        signUpViewModel.passwordIsValid.drive(resultPassword).disposed(by: disposeBag)
        signUpViewModel.confirmIsValid.drive(resultConfirm).disposed(by: disposeBag)
        signUpViewModel.signUpEnabled.drive(resultSignUp).disposed(by: disposeBag)
        
        //Then
        XCTAssertTrue(resultEmail.value)
        XCTAssertTrue(resultPassword.value)
        XCTAssertTrue(resultConfirm.value)
        XCTAssertTrue(resultSignUp.value)
    }
    
}
