//
//  CarPropertiesMappingHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 15.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

class StringFormatterHelper {
    
    private let defaultPropertyValue = NSLocalizedString("Not defined", comment: "")
    private let defaultDescritionValue = NSLocalizedString("No description", comment: "")
    
    func engineStringFormatter(cylinder: Int) -> String {
        return cylinder < 0 ? defaultPropertyValue : String(format: NSLocalizedString("EngineValueFormat", comment: ""), Float(cylinder/1000))
    }
    func hpPowerStringFormatter(hp: Int) -> String {
        return hp < 0 ? defaultPropertyValue : String(format: NSLocalizedString("HpPowerValueFormat", comment: ""), hp)
    }
    func intPropertyStringFormatter(value: Int) -> String {
        return value < 0 ? defaultPropertyValue : String(value)
    }
    func mileageStringFormatter(km: Int) -> String {
        return km < 0 ? defaultPropertyValue : String(format: NSLocalizedString("MileageValueFormat", comment: ""), km)
    }
    func propertyStringFormatter(value: String) -> String {
        return value.isEmpty ? defaultPropertyValue : value
    }
    func descriptionStringFormatter(value: String) -> String {
        return value.isEmpty ? defaultDescritionValue : value
    }
}


