//
//  FavoritesViewModelTests.swift
//  My MMRTests
//
//  Created by Hady Helal on 24/12/2021.
//

import XCTest
@testable import My_MMR

class FavoritesViewModelTests: XCTestCase {

    var sut: FavoritesViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FavoritesViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
        
    }


}
