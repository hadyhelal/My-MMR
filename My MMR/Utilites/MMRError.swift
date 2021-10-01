//
//  MMRError.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import Foundation

enum MMRError : String , Error {
    case invalidUsername  = "Invalid URL"
    case unableToComplete = "Plaease check your internet connection and try again."
    case invalidResponse  = "Make sure you wrote summoner name correctly and try again"
    case invalidData      = "Invalid data have been recieved!"
}