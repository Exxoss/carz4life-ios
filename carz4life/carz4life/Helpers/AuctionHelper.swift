//
//  AuctionHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 15.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

func getStepForPrice(currentPrice: Float) -> Float {
    return currentPrice >= 100000 ? 1000 : currentPrice >= 50000 ? 500 : 100
}
