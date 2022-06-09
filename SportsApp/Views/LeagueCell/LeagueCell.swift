//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueBadgeImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var youTubeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func youTubeButtonPressed(_ sender: UIButton) {
    }
    
}
