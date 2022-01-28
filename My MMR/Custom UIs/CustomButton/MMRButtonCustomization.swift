//
//  MMRSearchButton.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import UIKit

struct MMRButtonCustomization {
    static func configureSearchButton(button : UIButton){
        button.layer.cornerRadius    = 10
        button.titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitleColor(.white, for: .normal)
    }
    
    static func configureServerButton(button : UIButton){
        button.layer.cornerRadius    = 10
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth     = 2
        button.layer.borderColor     = UIColor.systemGray4.cgColor
        button.clipsToBounds         = true
        button.backgroundColor       = .tertiarySystemBackground
        button.titleLabel?.font      = UIFont.preferredFont(forTextStyle: .subheadline)
    }
}
