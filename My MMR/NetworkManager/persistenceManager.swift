//
//  persistenceManager.swift
//  My MMR
//
//  Created by Hady Helal on 09/10/2021.
//

import Foundation

enum persistanceActionType {case add , remove}

enum persistanceManager {
    static var defaults = UserDefaults.standard
    enum key {
        static var favorites = "favorites"
    }
    
    static func updateFavorites(newPlayer : SavedFavorites, actionType : persistanceActionType, completed : @escaping (MMRError?) -> Void) {
        retrieveFavorites { (result) in
            print(result)
            switch result {
            case .success(var favoritePlayers):
                switch actionType {
                case .add:
                    guard !favoritePlayers.contains(newPlayer) else {
                        completed(.alreadyFavorited)
                        return
                    }
                    favoritePlayers.append(newPlayer)
                case .remove:
                    favoritePlayers.removeAll {$0.summonerName == newPlayer.summonerName }
                }
                
                completed(saveFavorites(players: favoritePlayers))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[SavedFavorites] , MMRError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: key.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([SavedFavorites].self, from: favoritesData)
            completed(.success(decodedFavorites))
        } catch {
            print(error)
            completed(.failure(.unableToRetrieve))
        }
    }
    
    static func saveFavorites( players : [SavedFavorites]) -> MMRError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(players)
            defaults.setValue(encodedFavorite, forKey: key.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
