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
    
    var youTubeLink: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func youTubeButtonPressed(_ sender: UIButton) {
        guard let url = URL(string: youTubeLink ?? "https://www.youtube.com/") else { return }
        UIApplication.shared.open(url)
    }
    
}
