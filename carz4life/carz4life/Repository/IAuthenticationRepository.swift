//
//  IAuthenticationRepository.swift
//  carz4life
//
//  Created by Arthur Quemard on 30.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation
import RxSwift

protocol IAuthenticationRepository {
    var inProcess: Variable<Bool>{get}
    var apiErrString: Variable<String>{get}

    func signIn(email: String, password: String)
    func signUp(email: String, password: String)
    func logout()
}
