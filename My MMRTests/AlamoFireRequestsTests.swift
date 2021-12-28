//
//  AlamoFireRequestsTests.swift
//  My MMRTests
//
//  Created by Hady Helal on 24/12/2021.
//

import XCTest
@testable import My_MMR
class AlamoFireRequestsTests: XCTestCase {

    var sut: AlamoFireRequests!

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = AlamoFireRequests()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()

    }

    func testFetchSummonerMMRData() throws {
        
        let promise = XCTestExpectation(description: "Fetch summoner data completed")
        var responsePlayerMMR: PlayerMMR?
        var responseError: MMRError?
        
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Error: stubs not found")
            return
        }
        
        let urlRequest = URLRequest(url: URL(fileURLWithPath: bundle))

        sut.fetchSummonerMMRData(with: urlRequest) { result in
            switch result {
            case .success(let playerData):
                responsePlayerMMR = playerData
            case .failure(let error):
                responseError = error
                print(error)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
        XCTAssertNotNil(responsePlayerMMR)
        XCTAssertNil(responseError)
    }
    
    func testCheckIfSummonerNameHasData() throws {
        let promise = XCTestExpectation(description: "Checking error done successfully")
        var responseRequest: String?
        var responseError: MMRError?
        guard let bundle = Bundle.unitTest.path(forResource: "stubFirstRequest", ofType: "json") else {
            XCTFail("Error: stubFirstRequest notFound")
            return
        }
        
        let urlRequest = URLRequest(url: URL(fileURLWithPath: bundle))
        
        sut.checkIfSummonerNameHasData(with: urlRequest) { result in
            switch result {
            case .success(let requsetSucceded):
                responseRequest = requsetSucceded
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
        XCTAssertNotNil(responseRequest)
        XCTAssertNil(responseError)
    
    }
    
}
