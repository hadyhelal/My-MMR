//
//  SearchModelView.swift
//  My MMR
//
//  Created by Hady Helal on 29/10/2021.
//

import UIKit.UIButton

class SearchModelView {
    let chosenServer        = Dynamic("EUNE")
    let summonerName        = Dynamic("")
    let loadingScreenStatus = Dynamic(false)
    
    //Dependacy Injection
    var dropDown: DropDownProtocol
    var alamoFire: AlamoFireProtocol
    
    init( dropDown : DropDownProtocol, alamoFire: AlamoFireProtocol) {
        self.dropDown  = dropDown
        self.alamoFire = alamoFire
    }
    
    func getSummunorMMR(playerName: String, completed: @escaping (Result<PlayerMMR, MMRError>)-> Void){
        loadingScreenStatus.value = true
        alamoFire.getUserData(playerName: playerName, server: chosenServer.value) {  result in
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
        dropDown.handleServerSelection(sender) { [weak self] chosenServer in
            self?.chosenServer.value = chosenServer
        }
    }
    
}
