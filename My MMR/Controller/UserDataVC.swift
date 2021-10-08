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
    
    var playerData : PlayerMMR!
    let NotAvailiable = "N/A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchVC.delegate = self
        configureViewControllerUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
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
        self.presentAlertOnMainThread(title: "Add to favorite", message: "You successfully favorited this user!", buttonTitle: "Ok")
    }
    
    func configureRankedStatus() {
        guard let mmr = playerData.ranked.avg , var summary = playerData.ranked.summary else {
            rankedMMR.text     = NotAvailiable
            rankedSummary.text = NotAvailiable
            return
        }
        rankedMMR.text         = String(mmr)
        rankedSummary.text     = summary.extractMMRSummary(summmary: &summary)

    }
    
    func configureNormalStatus() {
        guard let mmr = playerData.normal.avg , let currentRank = playerData.normal.closestRank else {
            normalMMR.text     = NotAvailiable
            normalSummary.text = NotAvailiable
            return
        }
        normalMMR.text         = String(mmr)
        normalSummary.text     = currentRank
    }
    
    func configureAramStatus() {
        guard let mmr = playerData.ARAM.avg , let currentRank = playerData.ARAM.closestRank else {
            aramMMR.text     = NotAvailiable
            aramSummary.text = NotAvailiable
            return
        }
        aramMMR.text         = String(mmr)
        aramSummary.text     = currentRank
    }
    

    
    
}


extension UserDataVC : doHasUserData {
    func userData(playerData: PlayerMMR ,playerName : String) {
        self.playerData = playerData
         
        DispatchQueue.main.async {
            self.title                 = playerName
            self.currentRank.text      = playerData.ranked.closestRank ?? self.NotAvailiable
            self.summonerUsername.text = playerName
            self.configureRankedStatus()
            self.configureNormalStatus()
            self.configureAramStatus()
        }
        print("lollllllllll")
    }
    
}
