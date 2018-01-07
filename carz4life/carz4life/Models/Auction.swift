//
//  Auction.swift
//  carz4life
//
//  Created by Arthur Quemard on 04/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa

class Auction {
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    let id: String
    var title: Variable<String>
    var auctionStatus: Variable<AuctionStatus>
    var auctionWinnerId: Variable<String>
    var startAuctionDate: Variable<Date>
    var endAuctionDate: Variable<Date>
    var imagesURL: Variable<[String]>
    var price: Variable<Float>
    var mark: Variable<String>
    var model: Variable<String>
    var description: Variable<String>
    var carProperties: CarProperties
    var bidHistory: Variable<[String]>
    
    var timeBeforeOpening = Variable<TimeInterval>(0)
    var timeBeforeClosing = Variable<TimeInterval>(0)
    private var timerBeforeOpening: Timer!
    private var timerBeforeClosing: Timer!
    
    init(id: String) {
        
        self.id = id
        self.title = Variable("")
        self.auctionStatus = Variable(AuctionStatus.closed)
        self.auctionWinnerId = Variable("")
        self.startAuctionDate = Variable(Date())
        self.endAuctionDate = Variable(Date())
        self.imagesURL = Variable([])
        self.price = Variable(0)
        self.mark = Variable("")
        self.model = Variable("")
        self.description = Variable("")
        self.bidHistory = Variable([])
        self.carProperties = CarProperties()
        
        startAuctionDate.asObservable().subscribe({[weak self] in
            if self?.timerBeforeOpening != nil {
                self?.timerBeforeOpening.invalidate()
            }
            self?.timeBeforeOpening.value = timeIntervalRemainingFromDate(date: $0.element)
            self?.timerBeforeOpening = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(Auction.decreaseTimeBeforeOpening), userInfo: nil, repeats: true)
        }).disposed(by: disposeBag)
        
        endAuctionDate.asObservable().subscribe({[weak self] in
            if self?.timerBeforeClosing != nil {
                self?.timerBeforeClosing.invalidate()
            }
            self?.timeBeforeClosing.value = timeIntervalRemainingFromDate(date: $0.element)
            self?.timerBeforeClosing = Timer.scheduledTimer(timeInterval: 1, target: self as Any, selector: #selector(Auction.decreaseTimeBeforeClosing), userInfo: nil, repeats: true)
        }).disposed(by: disposeBag)
    }
}

extension Auction {
    //MARK: - Private func
    //time before auction evolution
    @objc private func decreaseTimeBeforeOpening() {
        if (self.timeBeforeOpening.value > 0) {
            self.timeBeforeOpening.value -= 1
        }
    }
    //time before auction evolution
    @objc private func decreaseTimeBeforeClosing() {
        if (self.timeBeforeClosing.value > 0) {
            self.timeBeforeClosing.value -= 1
        }
    }
}

enum AuctionStatus: Int {
    case pending = 0
    case alive = 1
    case closed = 2
}
