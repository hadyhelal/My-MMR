//
//  PlayerMMR.swift
//  My MMR
//
//  Created by Hady Helal on 29/09/2021.
//

import Foundation
import ObjectMapper
// MARK: - PlayerMMR

struct PlayerMMR: Codable,Mappable{
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        ranked <- map["ranked"]
        normal <- map["normal"]
        ARAM   <- map["ARAM"]
    }

    var ranked: Ranked?
    var normal: Aram?
    var ARAM: Aram?
}

// MARK: - Ranked
struct Ranked: Codable ,Mappable{
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
         avg <- map["avg"]
         err <- map["err"]
         warn <- map["warn"]
         summary <- map["summary"]
         closestRank <- map["closestRank"]
         percentile <- map["percentile"]
         tierData <- map["tierData"]
         timestamp <- map["timestamp"]
         historical <- map["historical"]
         historicalTierData <- map["historicalTierData"]
    }
    
    var avg : Int?
    var err: Int?
    var warn: Bool?
    var summary, closestRank: String?
    var percentile: Int?
    var tierData: [TierDatum]?
    var timestamp: Int?
    var historical: [Historical]?
    var historicalTierData: [HistoricalTierDatum]?
}

// MARK: - Aram
struct Aram: Codable , Mappable{
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
         avg <- map["avg"]
         err <- map["err"]
         warn <- map["warn"]
         closestRank <- map["closestRank"]
         percentile <- map["percentile"]
         timestamp <- map["timestamp"]
         historical <- map["historical"]
    }
    
    var avg: Int?
    var err: Int?
    var warn: Bool?
    var closestRank: String?
    var percentile: Double?
    var timestamp: Int?
    var historical: [Historical]?
}

// MARK: - Historical
struct Historical: Codable,Mappable {
     init?(map: Map) {}
    
    mutating func mapping(map: Map) {
         avg <- map["historical"]
         err <- map["historical"]
         warn <- map["historical"]
         timestamp <- map["historical"]
    }
    
    var avg : Int?
    var err: Int?
    var warn: Bool?
    var timestamp: Int?
}

struct HistoricalTierDatum: Codable ,Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
         name <- map["name"]
         avg <- map["avg"]
    }
    
    var name: String?
    var avg: Int?
}

struct TierDatum: Codable ,Mappable{
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        avg <- map["avg"]
        min  <- map["min"]
        max  <- map["max"]
        
    }
    
    var name: String?
    var avg, min, max: Int?
}

