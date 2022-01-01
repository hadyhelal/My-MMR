//
//  AlamoFireProtocols.swift
//  My MMR
//
//  Created by Hady Helal on 22/12/2021.
//

import Foundation

protocol AlamoFireManagerProtocol {
     func getUserData(playerName: String , server: String, completed: @escaping (Swift.Result<PlayerMMR , MMRError>) -> Void)
     
}

protocol AlamoFireRequestsProtocol {
     func fetchSummonerMMRData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<PlayerMMR,MMRError>) -> Void)
     
     func checkIfSummonerNameHasData(with urlRequest: URLRequest, completed: @escaping (Swift.Result<String, MMRError>) -> Void)
}
