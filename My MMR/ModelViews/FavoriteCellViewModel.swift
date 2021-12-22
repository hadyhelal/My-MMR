//
//  FavoriteCellViewModel.swift
//  My MMR
//
//  Created by Hady Helal on 30/10/2021.
//

import Foundation
import UIKit.UIImage

class FavoriteCellViewModel {
    let summonerImage: Dynamic<UIImage?> = Dynamic(nil)
    let summonerName:  Dynamic<String>   = Dynamic("")
    
    func set(favorite : SavedFavorites){
        summonerName.value  = favorite.summonerName
        summonerImage.value = RankImages.getRankImage(withRank: favorite.player.ranked?.closestRank ?? "N/A")
    }
}
