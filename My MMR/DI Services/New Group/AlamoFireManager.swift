//
//  AlamoFireManager.swift
//  My MMR
//
//  Created by Hady Helal on 18/12/2021.
//

import Foundation

class AlamoFireManager: AlamoFireProtocol {
     
     let operationQueue: OperationQueue
     
     init(operationQueue: OperationQueue) {
          self.operationQueue = operationQueue
     }
     
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void) {
          guard let url = getPLayerURL(playerName: playerName, server: server) else {
               completed(.failure(.invalidUsername))
               return
          }
          
          let urlRequest = URLRequest(url: url)
          
          let firstBlock = BlockOperation { [weak self] in
               self?.checkIfSummonerNameHasData(with: urlRequest) { [weak self] result in
                    switch result {
                    case .success(let failedWithNoRecentData ):
                         completed(.failure(MMRError(rawValue: failedWithNoRecentData)!) )
                         self?.operationQueue.cancelAllOperations()
                         return
                    case .failure(_):
                         break
                    }
               }
          }
          
          let secondBlock = BlockOperation { [weak self] in
               self?.fetchSummonerMMRData(with: urlRequest) { result in
                    switch result {
                    case .success(let playerMMR):
                         completed(.success(playerMMR))
                    case .failure(let error):
                         completed(.failure(error))
                    }
               }
          }
          
          secondBlock.addDependency(firstBlock)
          operationQueue.addOperations([firstBlock,secondBlock], waitUntilFinished: false)
     }
     
     func getPLayerURL(playerName: String , server : String) -> URL? {
          let urlString = "https://\(server).whatismymmr.com/api/v1/summoner?name=\(playerName)"
          print(urlString)
          guard let urlLink = URL(string: urlString) else { return nil }
          return urlLink
     }
}
