//
//  User.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift

class User {
    //MARK: - Properties
    let id: String
    let email: Variable<String>
    
    //MARK: - Initializer
    init (id: String, email: String) {
        self.id = id
        self.email = Variable(email)
    }
}
