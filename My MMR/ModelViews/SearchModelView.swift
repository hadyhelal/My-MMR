//
//  SearchModelView.swift
//  My MMR
//
//  Created by Hady Helal on 29/10/2021.
//

import UIKit.UIButton
import DropDown

class SearchModelView {
    let chosenServer        = Dynamic("EUNE")
    let summonerName        = Dynamic("")
    let dropDown            = DropDown()
    let loadingScreenStatus = Dynamic(false)
    
    func getSummunorMMR(playerName: String, completed: @escaping (Result<PlayerMMR, MMRError>)-> Void){
        loadingScreenStatus.value = true
        AlamoFireManager.shared.getUserData(playerName: playerName, server: chosenServer.value) {  result in
            self.loadingScreenStatus.value = false

            switch result {
            case .success(let summonerMMR):
                completed(.success(summonerMMR))

            case .failure(let error):
                completed(.failure(error))
            }
        }
        
    }
    
    func handleServerSelection( _ sender : UIButton){
        dropDown.dataSource      = ["EUNE", "EUW", "NA", "KR"]
        dropDown.anchorView      = sender
        dropDown.bottomOffset    = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            sender.setTitle(item, for: .normal)
            self.chosenServer.value = item
        }
    }
    
}
