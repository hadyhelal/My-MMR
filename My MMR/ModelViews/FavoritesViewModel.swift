//
//  FavoritesViewModel.swift
//  My MMR
//
//  Created by Hady Helal on 30/10/2021.
//

import Foundation

class FavoritesViewModel {
    var favoritesArray: Dynamic<[SavedFavorites]> = Dynamic([])
    var favoritesFiltered: Dynamic<[SavedFavorites]> = Dynamic([])
    var favoritesSelected: Dynamic<[SavedFavorites]> = Dynamic([])
    var reloadTableViewData   = Dynamic(false)
    let showError             = Dynamic("")
    
    func retrieveFavorites(){
        persistanceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let favoritesArray):
                self.favoritesArray.value      = favoritesArray
                self.favoritesSelected.value   = favoritesArray
                self.reloadTableViewData.value = true
            case .failure(let err):
                self.showError.value = err.rawValue

            }
        }
    }
    
    func deleteFavorite(with deltedFavorite: SavedFavorites) {
        persistanceManager.updateFavorites(newPlayer: deltedFavorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard error == nil  else {
                self.showError.value = "Can't delete this player!"
                return
            }
            self.favoritesSelected.value.remove(deltedFavorite)
            self.favoritesArray.value.remove(deltedFavorite)
        }
    }
    
    func updateSearch(with filter: String?){
        guard let filter = filter  else { return }
        guard !filter.isEmpty else {
            favoritesSelected.value  = favoritesArray.value
            reloadTableViewData.value.toggle()
            return
        }
        self.favoritesSelected.value = favoritesArray.value.filter {$0.summonerName.lowercased().contains(filter.lowercased())}
        reloadTableViewData.value.toggle()
    }
}
