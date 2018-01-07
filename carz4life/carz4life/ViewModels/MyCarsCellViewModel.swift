//
//  MyCarsCellViewModel.swift
//  carz4life
//
//  Created by Arthur Quemard on 21.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MyCarsCellViewModel {
    //MARK: - Properties
    //MARK: Outputs
    let title: Driver<String>
    let mark: Driver<String>
    let model: Driver<String>
    
    init(auction: Auction) {
        title = auction.title.asObservable().asDriver(onErrorJustReturn: "")
        mark = auction.mark.asObservable().asDriver(onErrorJustReturn: "")
        model = auction.model.asObservable().asDriver(onErrorJustReturn: "")
    }
}
