//
//  AlamoFireManager.swift
//  My MMR
//
//  Created by Hady Helal on 18/12/2021.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

protocol AlamoFireProtocol {
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void)
     
     func getPLayerURL(playerName: String , server: String) -> URL?
}

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
          let firstBlock = BlockOperation {
               self.checkIfSummonerNameHasData(with: urlRequest) { [weak self] result in
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
          
          let secondBlock = BlockOperation {
               Alamofire.request(urlRequest).responseObject { (response: DataResponse<PlayerMMR>) in
                    guard response.error == nil else {
                         completed(.failure(.unableToComplete))
                         return
                    }
                    
                    if response.response?.statusCode == 404 {
                         completed(.failure(.invalidUsername))
                         return
                    }
                    
                    guard response.response?.statusCode == 200 else {
                         completed(.failure(.invalidResponse))
                         return
                    }
                    
                    guard let playerData = response.result.value else {
                         completed(.failure(.invalidData))
                         return
                    }
                    print(playerData)
                    completed(.success(playerData))
               }
          }
          
          secondBlock.addDependency(firstBlock)
          operationQueue.addOperations([firstBlock,secondBlock], waitUntilFinished: false)
     }
     
     func getPLayerURL(playerName: String , server : String) -> URL? {
          let urlString = "https://\(server).whatismymmr.com/api/v1/summoner?name=\(playerName)"
          print(urlString)
          guard let urlLink = URL(string: urlString) else { return nil}
          return urlLink
     }
     
     func checkIfSummonerNameHasData(with urlRequest: URLRequest,
                                   completed: @escaping (Swift.Result<String, MMRError>) -> Void){
          
          Alamofire.request(urlRequest).responseObject { (response: DataResponse<FailedWithNoRecentData>) in
               guard response.error == nil else {
                    completed(.failure(.unableToComplete))
                    return
               }
               
               guard let modeledWithNewRequest = response.result.value?.error else {
                    completed(.failure(.invalidData))
                    return
               }
               print(modeledWithNewRequest)
               completed(.success((modeledWithNewRequest.message!)) )
          }
          
     }
}
