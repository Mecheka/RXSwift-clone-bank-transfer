//
//  BankList.swift
//  Clone transfer
//
//  Created by Suriya on 14/6/2564 BE.
//

import Foundation
import ObjectMapper

struct Bank: Mappable {
    
    var code: String?
    var abv: String?
    var order: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        abv <- map["abv"]
        order <- map["order"]
    }
}
