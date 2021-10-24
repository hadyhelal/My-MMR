//
//  SavedFavorites.swift
//  My MMR
//
//  Created by Hady Helal on 17/10/2021.
//

import Foundation

struct SavedFavorites : Codable , Equatable{
    
    static func == (lhs: SavedFavorites, rhs: SavedFavorites) -> Bool {
        return lhs.summonerName == rhs.summonerName
    }
    
    let player : PlayerMMR
    let summonerName : String
    let server : String
}
