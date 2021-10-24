//
//  ViewController.swift
//  My MMR
//
//  Created by Hady Helal on 28/09/2021.
//

import UIKit
import DropDown
import LeagueAPI
protocol doHasUserData {
    func userData(playerData : SavedFavorites)
}

class SearchVC: UIViewController {
    
    var dropDown = DropDown()
    var delegate : doHasUserData?
    var playerData : PlayerMMR?
    var chosenServer : String = Region.EUNE.rawValue
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var serverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapRecognizer()
        configureVCCustomisation()
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.text = .none
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func searchVC(_ sender: UIButton) {
        authenticateGettingSummoner()
    }
    
    @IBAction func serverDropDown(_ sender: UIButton) {
        dropDown.dataSource      = ["EUNE", "EUW", "NA", "KR"]
        dropDown.anchorView      = sender
        dropDown.bottomOffset    = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            sender.setTitle(item, for: .normal)
            self.chosenServer = item
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    func authenticateGettingSummoner(){
        getSummunorMMR { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let summonerMMR):
                self.playerData = summonerMMR
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: SeguesID.toUserDataVC, sender: self)
                    guard let sendPlayerData = self.playerData else {  return }
                    let playerInfo = SavedFavorites(player: sendPlayerData, summonerName: self.textField.text!, server: self.chosenServer)
                    self.delegate?.userData(playerData: playerInfo)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SeguesID.toUserDataVC {
            let destination = segue.destination as? UserDataVC
            self.delegate = destination
        }
    }
    
    func getSummunorMMR(completed : @escaping (Result<PlayerMMR, MMRError>)-> Void){
        self.showLoadingScreen()
        guard let summonerName = textField.text?.replacingOccurrences(of: " ", with: "") else {
            self.stopLoadingScreen()
            completed(.failure(.invalidUsername))
            return
        }
        
        NetworkManager.shared.getUserData(playerName: summonerName, server: chosenServer) { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingScreen()
            
            switch result {
            case .success(let summonerMMR):
                completed(.success(summonerMMR))
                
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func configureVCCustomisation(){
        MMRTextField.configureTF(textField: textField)
        MMRButtonCustomization.configureSearchButton(button: searchButton)
        MMRButtonCustomization.configureServerButton(button: serverButton)
    }
    
    func tapRecognizer(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    let x = (5 ,1)
}


extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authenticateGettingSummoner()
        return true
        
    }
}

//
//Connect.league.lolAPI.getSummoner(byName: "HadyHulk", on:.EUNE ) { (summoner, errorMsg) in
//    if let summoner = summoner {
//        //Connect.league.lolAPI.rank
//        Connect.league.lolAPI.getChampionMasteries(by: summoner.id, on: .EUNE) { (championMasteries, errorMsg) in
//            if let championMasteries = championMasteries {
//                for mastery in championMasteries {
//                    print("Mastery\(mastery.championPoints)")
//                }
//            }
//            else {
//                print("Request failed cause: \(errorMsg ?? "No error description")")
//            }
//        }
//    }
//    else {
//        print("Request failed cause: \(errorMsg ?? "No error description")")
//    }
//}
