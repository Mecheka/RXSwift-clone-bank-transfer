//
//  BankListResponse.swift
//  Clone transfer
//
//  Created by Suriya on 14/6/2564 BE.
//

import Foundation
import ObjectMapper

struct BankList: Mappable {
    
    var bankList: [Bank]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        bankList <- map["content"]
    }
}
