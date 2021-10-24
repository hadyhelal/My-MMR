//
//  NetworkManager.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func getUserData(playerName : String , server : String , completed : @escaping (Result<PlayerMMR , MMRError>) -> Void){
        
        guard let url = getPLayerURL(playerName: playerName, server: server) else {
            completed(.failure(.invalidUsername))
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userMMR = try decoder.decode(PlayerMMR.self, from: data)
                completed(.success(userMMR))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getPLayerURL(playerName : String , server : String) -> URL? {
        
        let urlString = "https://\(server).whatismymmr.com/api/v1/summoner?name=\(playerName)"
        guard let urlLink = URL(string: urlString) else { return nil}
        return urlLink
    }
    
}
