//
//  AlamoFireManager.swift
//  My MMR
//
//  Created by Hady Helal on 18/12/2021.
//


//MARK: - This class is responsilbe for managing Alamofire requests and error threw.

import Foundation
import Resolver

class AlamoFireManager: AlamoFireManagerProtocol {
     
     @Injected var alamoFireRequest: AlamoFireRequestsProtocol
     
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void) {
          guard let url = URLComponent.getPLayerURL(playerName: playerName, server: server) else {
               completed(.failure(.invalidUsername))
               return
          }
          
          let urlRequest = URLRequest(url: url)
          
          alamoFireRequest.checkIfSummonerNameHasData(with: urlRequest) { [weak self] result in
               switch result {
               case .success(let failedWithNoRecentData ):
                    completed(.failure(MMRError(rawValue: failedWithNoRecentData)!) )
                    return
               case .failure(_):
                    self?.alamoFireRequest.fetchSummonerMMRData(with: urlRequest) { result in
                         switch result {
                         case .success(let playerMMR):
                              completed(.success(playerMMR))
                         case .failure(let error):
                              completed(.failure(error))
                         }
                    }
               }
          }
     }

}
