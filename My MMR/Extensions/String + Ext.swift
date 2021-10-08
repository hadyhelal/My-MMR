//
//  String + Ext.swift
//  My MMR
//
//  Created by Hady Helal on 07/10/2021.
//

import Foundation

extension String {
    func extractMMRSummary (summmary : inout String) -> String {
        var usedString = ""
        summmary = summmary.replacingOccurrences(of: "</b><br><br><span class=\"symbol--micro\"></span>", with: " ")
        summmary = summmary.replacingOccurrences(of: "</b>", with: "")
        summmary = summmary.replacingOccurrences(of: "<b>", with: "")
        for chr in summmary {
            if chr == "R" {
                usedString += "R"
                break
            }
            usedString += "\(chr)"
        }
        return usedString
    }
}
