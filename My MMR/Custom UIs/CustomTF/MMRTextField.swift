//
//  MMRTextField.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import UIKit

struct MMRTextField {
   static func configureTF(textField : UITextField){
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        
        textField.textColor = .label
        textField.tintColor = .label
        textField.textAlignment = .center
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.returnKeyType   = .go
        textField.backgroundColor = .tertiarySystemBackground
        textField.autocorrectionType = .no
        textField.clearButtonMode    = .whileEditing
    }
}
