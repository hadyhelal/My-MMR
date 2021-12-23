//
//  AlamoFireManagerTests.swift
//  My MMRTests
//
//  Created by Hady Helal on 18/12/2021.
//

import XCTest
@testable import My_MMR

class AlamoFireManagerTests: XCTestCase {

    var sut: AlamoFireManager!
    override func setUpWithError() throws {
        super.setUp()
        sut = AlamoFireManager(operationQueue: OperationQueue(), alamoFireRequest: AlamoFireRequests())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
