//
//  MappingHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 06.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift

class MappingHelper {

    func updateAuctionObjValuesFromDictionary(auction: inout Auction, dict: NSDictionary) {
        
        auction.title.value = dict.object(forKey: "title") as? String ?? ""
        auction.auctionStatus.value = AuctionStatus(rawValue: dict.object(forKey: "auction_status") as! Int) ?? AuctionStatus.closed
        auction.auctionWinnerId.value = dict.object(forKey: "auction_winner_id") as? String ?? ""
        auction.startAuctionDate.value = dateFromString(dateString: dict.object(forKey: "start_auction_date") as! String)
        auction.endAuctionDate.value = dateFromString(dateString: dict.object(forKey: "end_auction_date") as! String)
        auction.imagesURL.value = (dict.object(forKey: "image_urls") as? NSArray) as? [String] ?? []
        auction.price.value = dict.object(forKey: "price") as! Float
        auction.mark.value = dict.object(forKey: "mark") as! String
        auction.model.value = dict.object(forKey: "model") as! String
        auction.description.value = dict.object(forKey: "description") as? String ?? ""
        auction.bidHistory.value = (dict.object(forKey: "bid_history") as? NSArray) as? [String] ?? []
        
        let carProperties = (dict.object(forKey: "car_properties") as? NSDictionary ?? NSDictionary())
        auction.carProperties.engine.value = carProperties.object(forKey: "engine") as? Int ?? -1
        auction.carProperties.mileage.value = carProperties.object(forKey: "mileage") as? Int ?? -1
        auction.carProperties.gear.value = carProperties.object(forKey: "gear") as? String ?? ""
        auction.carProperties.seat.value = carProperties.object(forKey: "seat") as? Int ?? -1
        auction.carProperties.door.value = carProperties.object(forKey: "door") as? Int ?? -1
        auction.carProperties.fuel.value = carProperties.object(forKey: "fuel") as? String ?? ""
        auction.carProperties.hpPower.value = carProperties.object(forKey: "hp_power") as? Int ?? -1
        auction.carProperties.light.value = carProperties.object(forKey: "light") as? String ?? ""
        
    }
}
