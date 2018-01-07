//
//  AuctionCellViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 05.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class AuctionCellViewModel {
    //MARK: - Properties
    //MARK: Outputs
    let title: Driver<String>
    let articleImage: Driver<String>
    let mark: Driver<String>
    let model: Driver<String>
    let price: Driver<String>
    let timeBeforeOpening: Driver<String>
    let auctionStatus: Driver<AuctionStatus>
    
    
    //MARK: - Initializer
    init(auction: Auction) {
        title = auction.title.asObservable().asDriver(onErrorJustReturn: "")
        
        articleImage = auction.imagesURL.asObservable().map({
            $0.first ?? ""
        }).asDriver(onErrorJustReturn: "")
        
        mark = auction.mark.asObservable().asDriver(onErrorJustReturn: "")
        
        model = auction.model.asObservable().asDriver(onErrorJustReturn: "")
        
        price = auction.price.asObservable().map({stringFromPrices(price: $0)}).asDriver(onErrorJustReturn: "")
        
        timeBeforeOpening = auction.timeBeforeOpening.asObservable().map({stringFromTimeInterval(interval: $0)}).asDriver(onErrorJustReturn: "")
        
        auctionStatus = auction.auctionStatus.asObservable().asDriver(onErrorJustReturn: AuctionStatus.closed)
    }
}
