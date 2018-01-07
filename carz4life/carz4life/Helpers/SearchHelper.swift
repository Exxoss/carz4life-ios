//
//  SearchHelper.swift
//  carz4life
//
//  Created by Arthur Quemard on 11.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import Foundation

func filterAuctions(auctionData: [Auction], query: String) -> [Auction] {
    if !query.isEmpty {
        let queryArray = query.components(separatedBy: .whitespaces)
        return auctionData.filter({
            for word in queryArray {
                if ((!word.isEmpty) && !($0.mark.value.lowercased() + $0.model.value.lowercased() + $0.title.value.lowercased()).contains(word.lowercased())) {
                    return false
                }
            }
            return true
        })
    }
    return auctionData
}
