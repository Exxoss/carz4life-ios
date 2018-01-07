//
//  ColorHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 30.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit

class ColorHelper {
    //MARK: - Instance
    static let sharedInstance = ColorHelper()
    
    //MARK: - properties
    let primary = UIColor(red: 43/255, green: 128/255, blue: 185/255, alpha: 1)
    let secondary = UIColor(red: 214/255, green: 225/255, blue: 234/255, alpha: 1)
    let valid = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    let error = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    let warning = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1)
    let disabled = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
    
    //MARK: - Initializer
    private init() {
    }
}
