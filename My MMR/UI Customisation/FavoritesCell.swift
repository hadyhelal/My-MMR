//
//  FavoritesCell.swift
//  My MMR
//
//  Created by Hady Helal on 10/10/2021.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let FavoriteID = "FavoriteID"
    let viewModel         = FavoriteCellViewModel()
    @IBOutlet weak var summonerNameLabel: UILabel!
    
    @IBOutlet weak var summonerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        
        viewModel.summonerImage.bind { [weak self] image in
            self?.summonerImage.image = image
        }
        
        viewModel.summonerName.bind { [weak self] summonerName in
            self?.summonerNameLabel.text = summonerName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    
}
