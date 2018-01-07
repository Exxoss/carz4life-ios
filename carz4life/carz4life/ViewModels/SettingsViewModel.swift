//
//  SettingsViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 02/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsViewModel {
    //MARK: - Properties
    var repository: IAuthenticationRepository!
    
    //MARK: Outputs
    let userEmail: Driver<String>
    
    //MARK: - Initializer
    init() {
        repository = AuthenticationRepository()
        
        userEmail = UserManager.shardedInstance.user.email.asObservable().asDriver(onErrorJustReturn: "")
    }
    
    //MARK: - Command
    func logoutCommand() {
        repository.logout()
    }
}
