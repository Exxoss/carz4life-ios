
//
//  AuctionRepository.swift
//  carz4life
//
//  Created by Arthur Quemard on 05.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper

class AuctionRepository: IAuctionRepository {
    //MARK: - Properties
    private let ref: DatabaseReference!
    
    let inProcess: Variable<Bool>
    var apiErrString: Variable<String>
    var auctions: Variable<[Auction]>
    
    init() {
        ref = Database.database().reference()
        
        inProcess = Variable(false)
        apiErrString = Variable("")
        auctions = Variable([])
    }
    func setAuctionsData() {
        self.inProcess.value = true
        ref.child("auctions").observe(DataEventType.childAdded, with: {[weak self] snap in
            let auctionId = snap.key
            let auction = Auction(id: auctionId)
            self?.ref.child("auctions").child(auctionId).observe(DataEventType.value, with: {[weak auction] (snap) in
                MappingHelper().updateAuctionObjValuesFromDictionary(auction: &(auction)!, dict: snap.value as! NSDictionary)
                self?.inProcess.value = false
            })
            self?.auctions.value.append(auction)
        })
    }
    func bidAuction(auctionId: String, newPrice: Float) {
        self.inProcess.value = true
        let dto = Bidding(auctionId: auctionId, newPrice: newPrice)

        Alamofire.request(
            bidEndpointApiAdress,
            method: .post,
            parameters: Mapper().toJSON(dto),
            encoding: JSONEncoding.default
        )
    }
}
