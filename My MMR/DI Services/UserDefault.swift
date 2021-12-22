//
//  UserDefault.swift
//  My MMR
//
//  Created by Hady Helal on 01/11/2021.
//

import Foundation

enum persistanceActionType {case add , remove}

protocol UserDefaultProtocol {
    var defaults: UserDefaults { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    func updateFavorites(newPlayer : SavedFavorites, actionType : persistanceActionType, completed : @escaping (MMRError?) ->())
    func retrieveFavorites(completed: @escaping (Result<[SavedFavorites] , MMRError>) -> Void)
    func saveFavorites( players : [SavedFavorites]) -> MMRError?
}

class UserDefault: UserDefaultProtocol {
    var defaults = UserDefaults.standard
    let encoder  = JSONEncoder()
    let decoder  = JSONDecoder()
    
    enum key {
        static var favorites = "favorites"
    }
    
    func updateFavorites(newPlayer : SavedFavorites, actionType : persistanceActionType, completed : @escaping (MMRError?) -> Void) {
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
                
                completed(self.saveFavorites(players: favoritePlayers))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    func retrieveFavorites(completed: @escaping (Result<[SavedFavorites] , MMRError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: key.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decodedFavorites = try decoder.decode([SavedFavorites].self, from: favoritesData)
            completed(.success(decodedFavorites))
        } catch {
            print(error)
            completed(.failure(.unableToRetrieve))
        }
    }
    
    func saveFavorites( players : [SavedFavorites]) -> MMRError? {
        do {
            let encodedFavorite = try encoder.encode(players)
            defaults.setValue(encodedFavorite, forKey: key.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
