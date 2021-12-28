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
     
     @Injected var operationQueue: OperationQueue
     @Injected var alamoFireRequest: AlamoFireRequestsProtocol
     
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void) {
          guard let url = getPLayerURL(playerName: playerName, server: server) else {
               completed(.failure(.invalidUsername))
               return
          }
          
          let urlRequest = URLRequest(url: url)
          
          let firstRequest = BlockOperation { [weak self] in
               self?.alamoFireRequest.checkIfSummonerNameHasData(with: urlRequest) { [weak self] result in
                    switch result {
                    case .success(let failedWithNoRecentData ):
                         self?.operationQueue.cancelAllOperations()
                         completed(.failure(MMRError(rawValue: failedWithNoRecentData)!) )
                         return
                    case .failure(_):
                         break
                    }
               }
          }
          
          let secondRequest = BlockOperation { [weak self] in
               self?.alamoFireRequest.fetchSummonerMMRData(with: urlRequest) { result in
                    switch result {
                    case .success(let playerMMR):
                         completed(.success(playerMMR))
                    case .failure(let error):
                         completed(.failure(error))
                    }
               }
          }
          
          secondRequest.addDependency(firstRequest)
          operationQueue.addOperations([firstRequest,secondRequest], waitUntilFinished: true)
     }
     
     func getPLayerURL(playerName: String , server : String) -> URL? {
          let urlString = "https://\(server).whatismymmr.com/api/v1/summoner?name=\(playerName)"
          print(urlString)
          guard let urlLink = URL(string: urlString) else { return nil }
          return urlLink
     }
}
