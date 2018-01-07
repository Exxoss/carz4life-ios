//
//  Repository.swift
//  carz4life
//
//  Created by Arthur Quemard on 30.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class AuthenticationRepository: IAuthenticationRepository {
    //MARK: Outputs
    let inProcess: Variable<Bool>
    let apiErrString: Variable<String>
    
    //MARK: Initializer
    init () {
        inProcess = Variable(false)
        apiErrString = Variable("")
    }
    
    //MARK: - Authentication
    func signIn(email: String, password: String) {
        apiErrString.value = ""
        inProcess.value = true
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, error) in
            self?.inProcess.value = false
            if error != nil {
                self?.apiErrString.value = (error?.localizedDescription)!
            }
        }
    }
    func signUp(email: String, password: String) {
        apiErrString.value = ""
        inProcess.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
            self?.inProcess.value = false
            if error != nil {
                self?.apiErrString.value = (error?.localizedDescription)!
            }
        }
    }
    func logout() {
         try! Auth.auth().signOut()
    }
    
    
}
