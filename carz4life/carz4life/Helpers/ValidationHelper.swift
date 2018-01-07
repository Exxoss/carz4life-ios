//
//  validationHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

//MARK: email verif
func isValidEmail(testStr:String) -> Bool {
    return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: testStr)
}
