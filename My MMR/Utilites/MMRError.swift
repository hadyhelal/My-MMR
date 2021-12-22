//
//  MMRError.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import Foundation

enum MMRError: String, Error {
    case invalidUsername  = "Invalid URL, Make sure you wrote summoner name correctly and try again"
    case unableToComplete = "Plaease check your internet connection and try again."
    case invalidResponse  = "Invalid response from the server"
    case invalidData      = "Invalid data have been recieved!"
    case unableToFavorite = "Unable to favorite this user!"
    case unableToRetrieve = "There was an error retreving your favorites!"
    case alreadyFavorited = "You already favorited this user before, favorite new one!"
    
    //these cases for second request.
    //this second request happens when something wrong with url name
    
    case noRecentData     = "No recent MMR data for summoner."
    case NotRecorded      = "Summoner is not on record."
}
