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

final class SearchVC: UIViewController {
    
    var dropDown = DropDown()
    var delegate: doHasUserData?
    var playerData: PlayerMMR?
    var chosenServer: String = Region.EUNE.rawValue
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var serverButton: UIButton!
    
    var summonerName : String {
        guard let playerName = textField.text?.replacingOccurrences(of: " ", with: "") else {
            self.stopLoadingScreen()
            return textField.text!
        }
        return playerName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapRecognizer(view: self.view)
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

                let playerInfo = SavedFavorites(player: self.playerData!,
                                                          summonerName: self.summonerName,
                                                          server: self.chosenServer)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: SeguesID.toUserDataVC, sender: self)
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
        AlamoFireManager.shared.getUserData(playerName: summonerName, server: chosenServer) { [weak self] result in
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
    
}

extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authenticateGettingSummoner()
        return true
        
    }
}
