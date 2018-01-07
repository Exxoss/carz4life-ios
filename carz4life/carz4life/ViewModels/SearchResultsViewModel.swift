//
//  SearchResultsViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 05.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchResultsViewModel {
    //MARK: - Properties
    var repository: IAuctionRepository!
    let disposeBag = DisposeBag()
    private var auctions = Variable<[Auction]>([])
    private var auctionsDisplayedData = Variable<[Auction]>([])
    
    //MARK: Inputs
    let searchText = Variable("")
    
    //MARK: Output
    var auctionsDisplayed: Driver<[Auction]>
    var isLoadingData: Driver<Bool>
    var selectedAuction: Variable<Auction?>
    
    //MARK: - Initializer
    init() {
        repository = AuctionRepository()
        repository.setAuctionsData()
        
        selectedAuction = Variable(nil)
        repository.auctions.asObservable().asDriver(onErrorJustReturn: []).drive(auctions).disposed(by: disposeBag)
        
        isLoadingData = repository.inProcess.asObservable().asDriver(onErrorJustReturn: false)
        
        auctionsDisplayed = Observable.combineLatest(auctions.asObservable(), searchText.asObservable()){auctions, query in
                return filterAuctions(auctionData: auctions, query: query).sorted(by: {$0.auctionStatus.value.rawValue < $1.auctionStatus.value.rawValue})
            }.asDriver(onErrorJustReturn: [])
        
        auctionsDisplayed.drive(auctionsDisplayedData).disposed(by: disposeBag)
        
        isLoadingData.drive(onNext: {[weak self] in
            if !$0 {
                self?.auctions.value = (self?.auctions.value.sorted(by: {$0.auctionStatus.value.rawValue < $1.auctionStatus.value.rawValue}))!
            }
        }).disposed(by: disposeBag)
    }
    
    func selectAuctionCommand(index: Int) {
        selectedAuction.value = auctionsDisplayedData.value[index]
    }
}
