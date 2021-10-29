//
//  FavoritesCell.swift
//  My MMR
//
//  Created by Hady Helal on 10/10/2021.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let FavoriteID = "FavoriteID"
    
    @IBOutlet weak var summonerNameLabel: UILabel!
    
    @IBOutlet weak var summonerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func set(favorite : SavedFavorites){
        summonerNameLabel.text = favorite.summonerName
        summonerImage.image    = RankImages.getRankImage(withRank: favorite.player.ranked?.closestRank ?? "N/A")
    }
    
}
