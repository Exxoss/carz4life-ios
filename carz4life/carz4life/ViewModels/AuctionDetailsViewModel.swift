//
//  AuctionDetailsViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 14.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa

class AuctionDetailsViewModel {
    //MARK: - Properties
    var repository: IAuctionRepository!
    let disposeBag = DisposeBag()
    
    var priceAfterBid = Variable<Float>(0)
    let auctionId: String
    
    //MARK: Outputs
    var articleImageUrls : Driver<[String]>
    
    var title : Driver<String>
    var userParticipateToTheAuction : Driver<Bool>
    var userIsTheCurrentWinner : Driver<Bool>
    var shouldBidButtonBeEnable : Driver<Bool>
    var auctionStatus : Driver<AuctionStatus>
    var timerBeforeStatusChange : Driver<String>
    var shouldTimerBeforeStatusChangeBeHidden : Driver<Bool>
    var currentPrice: Driver<String>
    var newPriceAfterBidding : Driver<String>
    var shouldNewPriceAfterBiddingBeHidden : Driver<Bool>
    var mark : Driver<String>
    var model : Driver<String>
    var description : Driver<String>
    
    var engine : Driver<String>
    var hpPower : Driver<String>
    var fuel : Driver<String>
    var gear : Driver<String>
    var door : Driver<String>
    var seat : Driver<String>
    var light : Driver<String>
    var mileage : Driver<String>
    
    var countUsersParticipatedToTheAuction : Driver<String>
    
    var isInProcess : Driver<Bool>
    
    //MARK: - Initializer
    init(auction: Auction, repo: IAuctionRepository) {
        
        repository = repo
        
        auctionId = auction.id
        
        let auctionStatusObservable = auction.auctionStatus.asObservable()
        let auctionWinnerIdObservable = auction.auctionWinnerId.asObservable()
        let priceObservable = auction.price.asObservable()
        let bidHistoryObservable = auction.bidHistory.asObservable()
        let inProcessObservable = repository.inProcess.asObservable()
        let stringFormatterHelper = StringFormatterHelper()
        
        priceObservable.map{$0 + getStepForPrice(currentPrice: $0)}.asDriver(onErrorJustReturn: 0).drive(priceAfterBid).disposed(by: disposeBag)
        
        articleImageUrls = auction.imagesURL.asObservable().asDriver(onErrorJustReturn: [])
        
        title = auction.title.asObservable().asDriver(onErrorJustReturn: "")
        
        userParticipateToTheAuction = bidHistoryObservable.map{$0.contains(UserManager.shardedInstance.user.id)}.asDriver(onErrorJustReturn: false)
        userIsTheCurrentWinner = auctionWinnerIdObservable.map{$0 == UserManager.shardedInstance.user.id}.asDriver(onErrorJustReturn: false)
        
        shouldBidButtonBeEnable = Observable.combineLatest(auctionStatusObservable, auctionWinnerIdObservable, inProcessObservable){status, winnerId, inProcess in
            status == AuctionStatus.alive && winnerId != UserManager.shardedInstance.user.id && !inProcess
        }.asDriver(onErrorJustReturn: false)
        
        auctionStatus = auctionStatusObservable.asDriver(onErrorJustReturn: AuctionStatus.closed)
        
        timerBeforeStatusChange = Observable.combineLatest(auction.timeBeforeOpening.asObservable(), auction.timeBeforeClosing.asObservable(), auctionStatusObservable){timeToStart, timeToClose, status in
            (status == AuctionStatus.alive) ? (String(format: NSLocalizedString("CloseInFormat", comment: ""), stringFromTimeInterval(interval: timeToClose))) : ((status == AuctionStatus.pending) ? stringFromTimeInterval(interval: timeToStart) : "")
        }.asDriver(onErrorJustReturn: "")
        shouldTimerBeforeStatusChangeBeHidden = auctionStatusObservable.map{$0 == AuctionStatus.closed}.asDriver(onErrorJustReturn: true)
        
        currentPrice = priceObservable.map{stringFromPrices(price: $0)}.asDriver(onErrorJustReturn: "")
        
        shouldNewPriceAfterBiddingBeHidden = auctionStatusObservable.map{$0 == AuctionStatus.closed}.asDriver(onErrorJustReturn: true)
        newPriceAfterBidding = priceAfterBid.asObservable().map{stringFromPrices(price: $0)}.asDriver(onErrorJustReturn: "")
        
        mark = auction.mark.asObservable().asDriver(onErrorJustReturn: "")
        
        model = auction.model.asObservable().asDriver(onErrorJustReturn: "")
        
        description = auction.description.asObservable().map{stringFormatterHelper.descriptionStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        
        engine = auction.carProperties.engine.asObservable().map{stringFormatterHelper.engineStringFormatter(cylinder: $0)}.asDriver(onErrorJustReturn: "")
        hpPower = auction.carProperties.hpPower.asObservable().map{stringFormatterHelper.hpPowerStringFormatter(hp: $0)}.asDriver(onErrorJustReturn: "")
        fuel = auction.carProperties.fuel.asObservable().map{stringFormatterHelper.propertyStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        gear = auction.carProperties.gear.asObservable().map{stringFormatterHelper.propertyStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        door = auction.carProperties.door.asObservable().map{stringFormatterHelper.intPropertyStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        seat = auction.carProperties.seat.asObservable().map{stringFormatterHelper.intPropertyStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        light = auction.carProperties.light.asObservable().map{stringFormatterHelper.propertyStringFormatter(value: $0)}.asDriver(onErrorJustReturn: "")
        mileage = auction.carProperties.mileage.asObservable().map{stringFormatterHelper.mileageStringFormatter(km: $0)}.asDriver(onErrorJustReturn: "")
        
        countUsersParticipatedToTheAuction = bidHistoryObservable.map{String($0.count)}.asDriver(onErrorJustReturn: "")
        
        isInProcess = inProcessObservable.asDriver(onErrorJustReturn: false)
    }
    
    //MARK: - Command
    func bidCommand() {
        repository.bidAuction(auctionId: auctionId, newPrice: priceAfterBid.value)
    }
}
