//
//  UserDataVCViewModel.swift
//  My MMR
//
//  Created by Hady Helal on 30/10/2021.
//

import Foundation

class UserDataVCViewModel {
    
    let favoriteUserStatus: Dynamic<String?> = Dynamic("")
    
    func favoriteUser (playerData: SavedFavorites , action: persistanceActionType){
        persistanceManager.updateFavorites(newPlayer: playerData, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.favoriteUserStatus.value = error!.rawValue
                return
            }
            self.favoriteUserStatus.value = nil
            
        }
    }
}
