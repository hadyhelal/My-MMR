//
//  MMRButton.swift
//  My MMR
//
//  Created by Hady Helal on 30/09/2021.
//

import UIKit
class MMRButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor : UIColor , title : String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor  : UIColor , title : String ){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }

}

