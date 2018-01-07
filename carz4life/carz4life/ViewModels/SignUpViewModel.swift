//
//  SignUpViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 30.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Firebase
import RxSwift
import RxCocoa

class SignUpViewModel {
    //MARK: - Properties
    var repository: IAuthenticationRepository!
    
    //MARK: Inputs
    var email = Variable("")
    var password = Variable("")
    var confirm = Variable("")
    
    //MARK: Outputs
    let signUpEnabled: Driver<Bool>
    let signUpExecuting: Driver<Bool>
    let errorMsg: Driver<String>
    let emailIsValid: Driver<Bool>
    let passwordIsValid: Driver<Bool>
    let confirmIsValid: Driver<Bool>
    
    //MARK: - Initializer
    init () {
        repository = AuthenticationRepository()
        
        let emailObservable = email.asObservable()
        let passwordObservable = password.asObservable()
        let confirmObservable = confirm.asObservable()
        
        signUpEnabled = Observable.combineLatest(emailObservable, passwordObservable, confirmObservable)
            {
                $0.count > 0
                && isValidEmail(testStr: $0)
                && $1.count > 6
                && $2 == $1
            }
            .asDriver(onErrorJustReturn: false)
        
        emailIsValid = emailObservable.map{isValidEmail(testStr: $0)}.asDriver(onErrorJustReturn: false)
        passwordIsValid = passwordObservable.map{$0.count > 6}.asDriver(onErrorJustReturn: false)
        confirmIsValid = Observable.combineLatest(passwordObservable, confirmObservable){$1 == $0 && $0.count > 0}.asDriver(onErrorJustReturn: false)
        
        signUpExecuting = repository.inProcess.asObservable().asDriver(onErrorJustReturn: false)
        errorMsg = repository.apiErrString.asObservable().asDriver(onErrorJustReturn: "")
    }
    //MARK: - Command
    func signUpCommand () {
       repository.signUp(email: email.value, password: password.value)
    }
}
