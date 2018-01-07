//
//  UserManager.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

class UserManager {
    //MARK: - Instance
    static let shardedInstance = UserManager()
    
    //MARK: - properties
    var user : User!

    //MARK: - Initializer
    private init() {
        user = User(id: "", email: "")
    }
}
