//
//  IAuctionRepository.swift
//  carz4life
//
//  Created by Arthur Quemard on 05.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift

protocol IAuctionRepository {
    var inProcess: Variable<Bool>{get}
    var apiErrString: Variable<String>{get}
    var auctions: Variable<[Auction]>{get}
    
    func setAuctionsData()
    func bidAuction(auctionId: String, newPrice: Float)
}
