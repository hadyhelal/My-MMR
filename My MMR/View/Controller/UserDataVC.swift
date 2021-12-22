//
//  UserDataVC.swift
//  My MMR
//
//  Created by Hady Helal on 04/10/2021.
//

import UIKit

class UserDataVC: UIViewController {
    
    //MARK: - Top View
    @IBOutlet weak var summonerUsername: UILabel!
    @IBOutlet weak var RankImage: UIImageView!
    @IBOutlet weak var currentRank: UILabel!
    
    //MARK: - Ranked View
    @IBOutlet weak var rankedView: UIView!
    @IBOutlet weak var rankedMMR: UILabel!
    @IBOutlet weak var rankedSummary: UILabel!
    
    //MARK: - Normal View
    @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var normalMMR: UILabel!
    @IBOutlet weak var normalSummary: UILabel!
    
    //MARK: - Aram
    @IBOutlet weak var aramView: UIView!
    @IBOutlet weak var aramMMR: UILabel!
    @IBOutlet weak var aramSummary: UILabel!
    
    let viewModel     = UserDataVCViewModel(persistanceManagers: UserDefault())
    let NotAvailiable = "N/A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllerUI()
        configureBindingInstances()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden            = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViewControllerUI(){
        rankedView.layer.cornerRadius = 20
        normalView.layer.cornerRadius = 20
        aramView.layer.cornerRadius   = 20
        
        let barBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        navigationItem.rightBarButtonItem = barBtn
    }
    
    @objc func addBtnTapped(){
        guard let playerData = viewModel.playerData else { return }
        viewModel.favoriteUser(playerData: playerData, action: .add)
    }
    
    
    func configureBindingInstances(){
        viewModel.rankedMMR.bind { [weak self] rankedMMR in
            self?.rankedMMR.text = rankedMMR
        }
        
        viewModel.rankedSummary.bind { [weak self] rankedText in
            self?.rankedSummary.text = rankedText
        }
        
        viewModel.normalMMR.bind { [weak self] normalMMR in
            self?.normalMMR.text = normalMMR
        }
        
        viewModel.normalSummary.bind { [weak self] normalSummary in
            self?.normalSummary.text = normalSummary
        }
        
        viewModel.aramMMR.bind { [weak self] aramMMR in
            self?.aramMMR.text = aramMMR
        }
        
        viewModel.aramSummary.bind { [weak self] aramSummary in
            self?.aramSummary.text = aramSummary
        }
        
        viewModel.favoriteUserStatus.bind { [weak self] status in
            if status != nil , status != "" {
                self?.presentAlertOnMainThread(title: "Error", message: status!, buttonTitle: "Ok")
            }else if status == nil {
                self?.presentAlertOnMainThread(title: "Add to favorite", message: "You successfully favorited this user!", buttonTitle: "Ok")
            }
        }
    }
    
}

extension UserDataVC : doHasUserData {
    func userData(playerData: SavedFavorites) {
        viewModel.playerData = playerData
        let closestRank = playerData.player.ranked?.closestRank
        DispatchQueue.main.async {
            self.RankImage.image       = RankImages.getRankImage(withRank: closestRank ?? self.NotAvailiable)
            self.currentRank.text      = closestRank ?? self.NotAvailiable
            self.summonerUsername.text = playerData.summonerName
            self.title                 = playerData.summonerName
            self.viewModel.configureRankedStatus()
            self.viewModel.configureNormalStatus()
            self.viewModel.configureAramStatus()
        }
        
    }
    
}
