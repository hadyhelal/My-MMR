//
//  RankImage.swift
//  My MMR
//
//  Created by Hady Helal on 24/10/2021.
//

import UIKit

enum RankImages{
    static func getRankImage (withRank rank: String) -> UIImage {
        guard let x = rank.first else {
            return RankLogos.unRanked!
        }
        
        var rankImage : UIImage {
            switch x {
            case "I":
                return RankLogos.iron!
            case "B":
                return RankLogos.bronze!
            case "S":
                return RankLogos.silver!
            case "P":
                return RankLogos.platinum!
            case "D":
                return RankLogos.diamond!
            case "M":
                return RankLogos.master!
            case "C":
                return RankLogos.challenger!
            case "G":
                if Array(rank)[1] == "d" { return RankLogos.grandMaster!} else { return RankLogos.gold!}
            default:
                return RankLogos.unRanked!
                
            }
        }
        return rankImage
    }
}
