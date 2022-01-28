//
//  DropDownList.swift
//  My MMR
//
//  Created by Hady Helal on 31/10/2021.
//

import UIKit.UIButton
import DropDown
protocol DropDownProtocol {
    func handleServerSelection(_ sender: UIButton, completed: @escaping (_ server : String)-> () )
}

class DropDownList: DropDownProtocol {
    func handleServerSelection(_ sender: UIButton, completed: @escaping (String) -> ()) {
        let dropDown             = DropDown()
        dropDown.dataSource      = ["EUNE", "EUW", "NA", "KR"]
        dropDown.anchorView      = sender
        dropDown.bottomOffset    = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            completed(item)
        }
    }
    
}

