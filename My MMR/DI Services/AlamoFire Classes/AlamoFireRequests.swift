//
//  AlamoFireRequests.swift
//  My MMR
//
//  Created by Hady Helal on 23/12/2021.
//

//MARK: - This class is responsible for RESTful APIs
import Foundation
import Alamofire
import AlamofireObjectMapper

class AlamoFireRequests: AlamoFireRequestsProtocol {
    
     func fetchSummonerMMRData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<PlayerMMR,MMRError>) -> Void) {
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
     
     func checkIfSummonerNameHasData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<String, MMRError>) -> Void){
          
          Alamofire.request(urlRequest).responseObject { (response: DataResponse<FailedWithNoRecentData>) in
               guard response.error == nil else {
                    completed(.failure(.unableToComplete))
                    return
               }
               
               guard let modeledWithNewRequest = response.result.value?.error else {
                    completed(.failure(.invalidData))
                    return
               }
               completed(.success((modeledWithNewRequest.message!)) )
          }
     }
}
