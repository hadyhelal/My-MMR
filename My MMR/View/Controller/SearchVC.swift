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
    
    var delegate: doHasUserData?
    var dropDown     = DropDown()
    var chosenServer = Region.EUNE.rawValue
    var viewModel    = SearchModelView()
    var loadingStatus : Bool = false {
        didSet {
            loadingStatus ? showLoadingScreen() : stopLoadingScreen()
        }
    }
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var serverButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        tapRecognizer(view: self.view)
        configureVCCustomisation()
        textField.delegate = self
        
        viewModel.chosenServer.bind { [weak self] chosenServer in
            self?.chosenServer = chosenServer
        }
        
        viewModel.loadingScreenStatus.bind { [weak self] loadingStatus in
            self?.loadingStatus = loadingStatus
        }
        
        viewModel.summonerName.bind { [weak self] summonerName in
            self?.textField.text = summonerName
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.text = .none
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func searchVC(_ sender: UIButton) {
        authenticateGettingSummoner()
    }
    
    func authenticateGettingSummoner(){
        guard let summonerName = textField.text?.replacingOccurrences(of: " ", with: "") else {
            return
        }
        viewModel.getSummunorMMR(playerName: summonerName) { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let summonerMMR):
                DispatchQueue.main.async {
                    let playerInfo = SavedFavorites(player: summonerMMR,
                                                    summonerName: summonerName,
                                                    server: self.chosenServer)
                    self.performSegue(withIdentifier: SeguesID.toUserDataVC, sender: self)
                    self.delegate?.userData(playerData: playerInfo)
                }
            
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @IBAction func serverDropDown(_ sender: UIButton) {
        viewModel.handleServerSelection(sender)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SeguesID.toUserDataVC {
            let destination = segue.destination as? UserDataVC
            self.delegate = destination
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
