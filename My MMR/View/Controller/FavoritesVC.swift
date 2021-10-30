//
//  FavoritesVC.swift
//  My MMR
//
//  Created by Hady Helal on 09/10/2021.
//

import UIKit

class FavoritesVC: UITableViewController{
    
    var favoritesArray    = [SavedFavorites] ()
    var favoritesFiltered = [SavedFavorites] ()
    var favoritesSelected = [SavedFavorites] ()
    let viewModel         = FavoritesViewModel()
 
    var delegate: doHasUserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
        configureSearchController()
        bindInstances()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.retrieveFavorites()
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
    
    func bindInstances() {
        viewModel.favoritesArray.bind { [weak self] favorites in
            self?.favoritesArray = favorites
        }
        
        viewModel.favoritesFiltered.bind { [weak self] filtered in
            self?.favoritesFiltered = filtered
        }
        
        viewModel.favoritesSelected.bind {[weak self] selected in
            self?.favoritesSelected = selected
        }
        
        viewModel.showError.bind { [weak self] msg in
            if msg != "" {
                self?.presentAlertOnMainThread(title: "Can't retrieve you favorites", message: msg, buttonTitle: "Ok")
            }
        }
        
        viewModel.reloadTableViewData.bind { [weak self] _ in
            self?.tableView.reloadData()
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
        self.performSegue(withIdentifier: SeguesID.toUserFromFavorite, sender: self)
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
        guard editingStyle  == .delete else { return }
        let deletedFavorite = favoritesSelected[indexPath.row]
        viewModel.deleteFavorite(with: deletedFavorite)
        tableView.deleteRows(at: [indexPath], with: .left)

    }
    
}

extension FavoritesVC : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearch(with: searchController.searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.favoritesSelected.value = viewModel.favoritesArray.value
        tableView.reloadData()
    }
    
}
