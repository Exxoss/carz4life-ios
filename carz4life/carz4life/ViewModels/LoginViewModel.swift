//
//  LoginViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//
import Firebase
import RxSwift
import RxCocoa

class LoginViewModel {
    //MARK: - Properties
    var repository: IAuthenticationRepository!
    //MARK: Inputs
    var email = Variable("")
    var password = Variable("")
    
    //MARK: Outputs
    let loginEnabled: Driver<Bool>
    let loginExecuting: Driver<Bool>
    let errorMsg: Driver<String>
    
    //MARK: - Initializer
    init () {
        repository = AuthenticationRepository()
        
        loginEnabled = Observable.combineLatest(email.asObservable(), password.asObservable())
            {
                $0.count > 0
                && isValidEmail(testStr: $0)
                && $1.count > 0
            }
            .asDriver(onErrorJustReturn: false)
        
        loginExecuting = repository.inProcess.asObservable().asDriver(onErrorJustReturn: false)
        errorMsg = repository.apiErrString.asObservable().asDriver(onErrorJustReturn: "")
        
    }
    
    //MARK: - Command
    func signInCommand() {
        repository.signIn(email: email.value, password: password.value)
    }
}
