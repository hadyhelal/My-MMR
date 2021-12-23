//
//  FailedWithNoRecentData.swift
//  My MMR
//
//  Created by Hady Helal on 18/12/2021.
//

import Foundation
import ObjectMapper

// MARK: - Welcome
struct FailedWithNoRecentData: Codable, Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        error <- map["error"]
    }
    
    var error: ErrorNoRecentData?
    
}

// MARK: - Error
struct ErrorNoRecentData: Codable, Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        code    <- map["code"]
    }
    
    var message: String?
    var code: Int?
}
