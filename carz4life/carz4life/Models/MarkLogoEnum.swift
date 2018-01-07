//
//  MarkLogoEnum.swift
//  carz4life
//
//  Created by Arthur Quemard on 15.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

enum MarkLogoEnum : String{
    case audi = "audi"
    case vw = "vw"
    case nissan = "nissan"
    case bmw = "bmw"
    case ferrari = "ferrari"
    case maserati = "maserati"
    case tesla = "tesla"
    case mclaren = "mclaren"
    case bugati = "bugati"
    case peugeot = "peugeot"
    case renault = "renault"
    case alfa = "alfa"
    case lambo = "lambo"
    case corvette = "corvette"
    case shelby = "shelby"
    case dodge = "dodge"
    case alpine = "alpine"
    case porsche = "porsche"
    case merco = "merco"
    case honda = "honda"
    case mitsub = "mitsub"
    case landrover = "landrover"
    case cadillac = "cadillac"
    case rr = "rr"
    case pagani = "pagani"
    case fiat = "fiat"
    case abarth = "abarth"
    case lotus = "lotus"
    case jaguar = "jaguar"
    case italdesign = "italdesign"
    case defaultLogo = "logo"
}

func setupLogoFromMark(mark: String) -> MarkLogoEnum{
    let logo = [
        "Audi" : MarkLogoEnum.audi,
        "VW" : MarkLogoEnum.vw,
        "Nissan" : MarkLogoEnum.nissan,
        "BMW" : MarkLogoEnum.bmw,
        "Ferrari" : MarkLogoEnum.ferrari,
        "Maserati" : MarkLogoEnum.maserati,
        "Tesla" : MarkLogoEnum.tesla,
        "McLaren" : MarkLogoEnum.mclaren,
        "Bugati" : MarkLogoEnum.bugati,
        "Peugeot" : MarkLogoEnum.peugeot,
        "Renault" : MarkLogoEnum.renault,
        "Alfa Romeo" : MarkLogoEnum.alfa,
        "Lamborghini" : MarkLogoEnum.lambo,
        "Corvette" : MarkLogoEnum.corvette,
        "Shelby" : MarkLogoEnum.shelby,
        "Dodge" : MarkLogoEnum.dodge,
        "Alpine" : MarkLogoEnum.alpine,
        "Porsche" : MarkLogoEnum.porsche,
        "Mercedes" : MarkLogoEnum.merco,
        "Honda" : MarkLogoEnum.honda,
        "Mitsubitchi" : MarkLogoEnum.mitsub,
        "Land Rover" : MarkLogoEnum.landrover,
        "Cadillac" : MarkLogoEnum.cadillac,
        "Rolls Royce" : MarkLogoEnum.rr,
        "Pagani" : MarkLogoEnum.pagani,
        "Fiat" : MarkLogoEnum.fiat,
        "Abarth" : MarkLogoEnum.abarth,
        "Lotus" : MarkLogoEnum.lotus,
        "Jaguar" : MarkLogoEnum.jaguar,
        "Italdesign" : MarkLogoEnum.italdesign
    ]
    
    if let valueMark = logo[mark] {
        return valueMark
    }
    
    return MarkLogoEnum.defaultLogo
}
