//
//  CarProperties.swift
//  carz4life
//
//  Created by Arthur Quemard on 04/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift

class CarProperties {
    var engine: Variable<Int>
    var mileage: Variable<Int>
    var gear: Variable<String>
    var seat: Variable<Int>
    var door: Variable<Int>
    var fuel: Variable<String>
    var hpPower: Variable<Int>
    var light: Variable<String>
    
    init() {
        self.engine = Variable(0)
        self.mileage = Variable(0)
        self.gear = Variable("")
        self.seat = Variable(0)
        self.door = Variable(0)
        self.fuel = Variable("")
        self.hpPower = Variable(0)
        self.light = Variable("")
    }
}
