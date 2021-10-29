//
//  FavoritesVC.swift
//  My MMR
//
//  Created by Hady Helal on 09/10/2021.
//

import UIKit

class FavoritesVC: UITableViewController{
    
    var favoritesArray : [SavedFavorites] = []
    var favoritesFiltered = [SavedFavorites] ()
    var favoritesSelected = [SavedFavorites] ()
    var delegate : doHasUserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveFavorites()
    }
    
    func configureViewController() {
        title = "Favorites"
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a Favorite"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    private func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.rowHeight       = 80
        tableView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellReuseIdentifier: FavoritesCell.FavoriteID)
    }
    
    func retrieveFavorites(){
        persistanceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let favoritesArray):
                self.favoritesArray    = favoritesArray
                self.favoritesSelected = favoritesArray
                self.tableView.reloadData()
            case .failure(let err):
                self.presentAlertOnMainThread(title: "Can't retrieve you favorites", message: err.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesSelected.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.FavoriteID, for: indexPath) as! FavoritesCell
        cell.set(favorite: favoritesSelected[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritesSelected[indexPath.row]
            self.performSegue(withIdentifier: "ToUserDataVC", sender: self)
            self.delegate?.userData(playerData: favorite)
        
     //Not enough games played solo/duo in last 30 days
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == SeguesID.toUserFromFavorite {
            let destination = segue.destination as? UserDataVC
            self.delegate = destination
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let deltedFavorite = favoritesSelected[indexPath.row]
        
        favoritesSelected.remove(deltedFavorite)
        favoritesArray.remove(deltedFavorite)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        persistanceManager.updateFavorites(newPlayer: deltedFavorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard error == nil  else {
                self.presentAlertOnMainThread(title: "Can't delete this player!", message: error!.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
    
}

extension FavoritesVC : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text  else { return }
        guard !filter.isEmpty else {
            favoritesSelected = favoritesArray
            tableView.reloadData()
            return
        }
        self.favoritesSelected = favoritesArray.filter {$0.summonerName.lowercased().contains(filter.lowercased())}
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        favoritesSelected = favoritesArray
        tableView.reloadData()
    }
    
    
}
