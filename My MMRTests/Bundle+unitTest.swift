//
//  Bundle+unitTest.swift
//  My MMRTests
//
//  Created by Hady Helal on 18/12/2021.
//

import Foundation
extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: AlamoFireManagerTests.self)
    }
}
