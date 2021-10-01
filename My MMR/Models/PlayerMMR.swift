//
//  PlayerMMR.swift
//  My MMR
//
//  Created by Hady Helal on 29/09/2021.
//

import Foundation

// MARK: - PlayerMMR
struct PlayerMMR: Codable {
    let ranked: Ranked
    let normal : Aram
    let ARAM: Aram
}

// MARK: - Ranked
struct Ranked: Codable {
    let avg : Int?
    let err: Int
    let warn: Bool
    let summary, closestRank: String?
    let percentile: Int?
    let tierData: [TierDatum]?
    let timestamp: Int?
    let historical: [Historical]
    let historicalTierData: [HistoricalTierDatum]
}

// MARK: - Aram
struct Aram: Codable {
    let avg: Int?
    let err: Int
    let warn: Bool
    let closestRank: String?
    let percentile: Double?
    let timestamp: Int?
    let historical: [Historical]
}

// MARK: - Historical
struct Historical: Codable {
    let avg : Int?
    let err: Int
    let warn: Bool
    let timestamp: Int?
}

struct HistoricalTierDatum: Codable {
    let name: String
    let avg: Int?
}

struct TierDatum: Codable {
    let name: String
    let avg, min, max: Int
}

