//
//  URlComponenet.swift
//  My MMR
//
//  Created by Hady Helal on 01/01/2022.
//

import Foundation

class URLComponent {
    static func getPLayerURL(playerName: String , server : String) -> URL? {
         var component = URLComponents()
         component.scheme = "https"
         component.host   = "\(server).whatismymmr.com"
         component.path   = "/api/v1/summoner"
         component.queryItems = [
              URLQueryItem(name: "name", value: playerName)
         ]
         
         return component.url
    }
    
}
