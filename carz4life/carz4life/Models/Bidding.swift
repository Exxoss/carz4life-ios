//
//  AuctionDTO.swift
//  carz4life
//
//  Created by Arthur Quemard on 19.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation
import ObjectMapper

class Bidding : Mappable {
    
    var auctionId: String?
    var userId: String?
    var newPrice: Float?
    
    required init?(map: Map) {
        
    }
    init (auctionId: String, newPrice: Float) {
        self.auctionId = auctionId
        self.userId = UserManager.shardedInstance.user.id
        self.newPrice = newPrice
    }
    
    func mapping(map: Map) {
        auctionId <- map["auction_id"]
        userId <- map["user_id"]
        newPrice <- map["new_price"]
    }
    
}
