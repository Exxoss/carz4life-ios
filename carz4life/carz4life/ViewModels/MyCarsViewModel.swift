//
//  MyCarsViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 21.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa

class MyCarsViewModel {
    //MARK: - Properties
    var repository: IAuctionRepository!
    private var auctionsData = Variable<[Auction]>([])
    let disposeBag = DisposeBag()
    
    //MARK: Outputs
    let auctions: Driver<[Auction]>
    let selectedItem: Variable<Auction?>
    let selectedAuction: Variable<Auction?>
    var isLoadingData: Driver<Bool>
    
    //MARK: - Initialisation
    init() {
        repository = AuctionRepository()
        repository.setAuctionsData()
        
        
        isLoadingData = repository.inProcess.asObservable().asDriver(onErrorJustReturn: false)
        
        selectedItem = Variable(nil)
        selectedAuction = Variable(nil)
        
        auctions = Observable.combineLatest(repository.auctions.asObservable(), repository.inProcess.asObservable())
            {auctionsData, inProcess in
                if !inProcess {
                    return auctionsData.filter({
                        return $0.auctionStatus.value != AuctionStatus.closed ? false : ($0.auctionWinnerId.value != UserManager.shardedInstance.user.id ? false : true)
                    })
                } else {
                    return []
                }
            }.asDriver(onErrorJustReturn: [])
        
        auctions.asObservable().asDriver(onErrorJustReturn: []).drive(auctionsData).disposed(by: disposeBag)
    }
    
    //MARK: - Commands
    func selectItemCommand(index: Int) {
        selectedItem.value = auctionsData.value[index]
    }
    func selectAuctionCommand(index: Int) {
        selectedAuction.value = auctionsData.value[index]
    }
    
}
