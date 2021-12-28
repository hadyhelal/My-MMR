//
//  stubGenerator.swift
//  My MMRTests
//
//  Created by Hady Helal on 24/12/2021.
//

import Foundation
@testable import My_MMR
class stubGenerator {
    
    func stubPlayerMMR() -> PlayerMMR? {
        
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json"),
              let data   = try? Data(contentsOf: URL(fileURLWithPath: bundle)) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let playerMMR = try? decoder.decode(PlayerMMR.self, from: data)
        return playerMMR
    }

}
