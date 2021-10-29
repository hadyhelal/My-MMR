//
//  AlamoFireManager.swift
//  My MMR
//
//  Created by Hady Helal on 24/10/2021.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

struct AlamoFireManager {
    static let shared = AlamoFireManager()
    
    private init () {}
    
    func getUserData(playerName : String , server : String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void) {
        guard let url = getPLayerURL(playerName: playerName, server: server) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        Alamofire.request(URLRequest(url: url )).responseObject { (response: DataResponse<PlayerMMR>) in
            guard response.error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            print(response.result.error)

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
    
    private func getPLayerURL(playerName : String , server : String) -> URL? {
        
        let urlString = "https://\(server).whatismymmr.com/api/v1/summoner?name=\(playerName)"
        print(urlString)
        guard let urlLink = URL(string: urlString) else { return nil}
        return urlLink
    }
}


//
//Alamofire.request(urlRequese).responseObject { response: DataResponse<PlayerMMR> in
//    guard response.error == nil else {
//        return
//    }
//
//    guard let data = response.data else {
//        return
//    }
//
//    let playerData = String(data: data, encoding: .utf8)
//
//    guard let playerDataa = playerData else {
//        print("nooo data maaan!!")
//        return
//    }
//    print(playerDataa)
//}
