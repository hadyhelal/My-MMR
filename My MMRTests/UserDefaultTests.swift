//
//  UserDefaultTests.swift
//  My MMRTests
//
//  Created by Hady Helal on 24/12/2021.
//

import XCTest
@testable import My_MMR
class UserDefaultTests: XCTestCase {

    var sut: UserDefault!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserDefault()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testSaveFavorites() throws {
        guard let player = stubGenerator().stubPlayerMMR() else {
            XCTFail("Error: can not fetching player from stub")
            return
        }
        
        let favoritesArray = [SavedFavorites(player: player, summonerName: "hadyhulk", server: "eune"),
                              SavedFavorites(player: player, summonerName: "testItya", server: "euw")]
        let responseError  = sut.saveFavorites(players: favoritesArray)
        
        XCTAssertNil(responseError)
    }
    
}
