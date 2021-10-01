//
//  ViewController.swift
//  My MMR
//
//  Created by Hady Helal on 28/09/2021.
//

import UIKit
import DropDown

class SearchVC: UIViewController {
    
    var dropDown = DropDown()
    
    var playerData : PlayerMMR?
    var chosenServer : String = Servers.eune.rawValue
    
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
        getSummunorMMR()
    }
    
    @IBAction func serverDropDown(_ sender: UIButton) {
        dropDown.dataSource      = [Servers.euw.rawValue , Servers.eune.rawValue , Servers.na.rawValue , Servers.kr.rawValue]
        dropDown.anchorView      = sender
        dropDown.bottomOffset    = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            sender.setTitle(item, for: .normal)
            self.chosenServer = item
        }
    }
    
    func getSummunorMMR(){
        self.showLoadingScreen()
        guard let summonerName = textField.text?.replacingOccurrences(of: " ", with: "") else { return }
        
        NetworkManager.shared.getUserData(playerName: summonerName, server: chosenServer) { [weak self] result in
            guard let self = self else { return }
            self.stopLoadingScreen()
            switch result {
            case .success(let playerMMR):
                print(playerMMR)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something wrong!", message: error.rawValue, buttonTitle: "Ok")
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
    
}


extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getSummunorMMR()
        return true
    }
}
