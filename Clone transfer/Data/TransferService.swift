//
//  TransferService.swift
//  Clone transfer
//
//  Created by Suriya on 14/6/2564 BE.
//

import Foundation
import Moya

enum TransferService {
    case getBankList
}

extension TransferService: TargetType {
    var baseURL: URL {
        return URL(string: "https://67e22eda4186.ngrok.io/")!
    }
    
    var path: String {
        switch self {
        case .getBankList:
            return "v1/transfer/bank-list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBankList:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getBankList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
