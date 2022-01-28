//
//  MMRBodyLabel.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import UIKit

class MMRBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlginment : NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlginment
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode      = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
