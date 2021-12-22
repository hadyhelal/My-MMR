//
//  AlamoFireProtocol.swift
//  My MMR
//
//  Created by Hady Helal on 22/12/2021.
//

import Foundation

protocol AlamoFireProtocol {
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void)
     
     func getPLayerURL(playerName: String , server: String) -> URL?
}

protocol AlamoFireRequests {
     func fetchSummonerMMRData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<PlayerMMR,MMRError>) -> Void)
     
     func checkIfSummonerNameHasData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<String, MMRError>) -> Void)
}
