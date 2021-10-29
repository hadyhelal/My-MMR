//
//  Connect.swift
//  My MMR
//
//  Created by Hady Helal on 11/10/2021.
//

import Foundation
import LeagueAPI

enum Connect {
    static let league = LeagueAPI(APIToken: "RGAPI-46e8c3f5-c214-48c4-8009-8e1a84b8ae58")

    subscript(index: Int) -> Bool {
        // Return an appropriate subscript value here.
        return true
    }
    
}
