//
//  SearchButton.swift
//  My MMR
//
//  Created by Hady Helal on 26/10/2021.
//
import UIKit

class SearchButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius    = 10
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
    }
}
