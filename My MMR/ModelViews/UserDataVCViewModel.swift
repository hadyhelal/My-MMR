//
//  UserDataVCViewModel.swift
//  My MMR
//
//  Created by Hady Helal on 30/10/2021.
//

import Foundation
import Resolver
class UserDataVCViewModel {
    
    let favoriteUserStatus: Dynamic<String?> = Dynamic("")
    var playerData: SavedFavorites?          = nil
    let NotAvailiable = "N/A"

    let rankedMMR     = Dynamic("")
    let rankedSummary = Dynamic("")
    
    let normalMMR     = Dynamic("")
    let normalSummary = Dynamic("")

    let aramMMR       = Dynamic("")
    let aramSummary   = Dynamic("")
    
    @Injected var persistanceM: UserDefaultProtocol
    
    func favoriteUser (playerData: SavedFavorites , action: persistanceActionType){
        persistanceM.updateFavorites(newPlayer: playerData, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.favoriteUserStatus.value = error!.rawValue
                return
            }
            self.favoriteUserStatus.value = nil
            
        }
    }
    
    func configureRankedStatus() {
        guard let mmr = playerData?.player.ranked?.avg , var summary = playerData?.player.ranked?.summary else {
            rankedMMR.value     = NotAvailiable
            rankedSummary.value = ""
            return
        }
        rankedMMR.value         = String(mmr)
        rankedSummary.value     = summary.extractMMRSummary(summmary: &summary)

    }
    
    func configureNormalStatus() {
        guard let mmr = playerData?.player.normal?.avg , let currentRank = playerData?.player.normal?.closestRank else {
            normalMMR.value     = NotAvailiable
            normalSummary.value = ""
            return
        }
        normalMMR.value         = String(mmr)
        normalSummary.value     = currentRank
        
    }
    
    func configureAramStatus() {
        guard let mmr = playerData?.player.ARAM?.avg , let currentRank = playerData?.player.ARAM?.closestRank else {
            aramMMR.value     = NotAvailiable
            aramSummary.value = ""
            return
        }
        aramMMR.value         = String(mmr)
        aramSummary.value     = currentRank
    }

}
