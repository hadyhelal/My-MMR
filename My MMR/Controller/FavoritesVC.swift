//
//  FavoritesVC.swift
//  My MMR
//
//  Created by Hady Helal on 09/10/2021.
//

import UIKit

class FavoritesVC: UITableViewController {
    
    var favoritesArray : [SavedFavorites] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        retrieveFavorites()
        
    }
    
    func retrieveFavorites(){
        persistanceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let FavoritesArray):
                self.favoritesArray = FavoritesArray
                print("favorites: \(FavoritesArray)")
                self.tableView.reloadData()
            case .failure(_):
                print("Failuer")
            }
        }
    }
    
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.rowHeight       = 80
        self.tableView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellReuseIdentifier: FavoritesCell.FavoriteID)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.FavoriteID, for: indexPath) as! FavoritesCell
        cell.set(favorite: favoritesArray[indexPath.row].player)
        return cell
    }
    
}
