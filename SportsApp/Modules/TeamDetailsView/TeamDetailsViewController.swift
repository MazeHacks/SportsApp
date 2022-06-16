//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 13/06/2022.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamBadgeImageView: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    
    var teamName: String?
    var teamBadge: String?
    var sport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: teamBadge ?? "")
        teamBadgeImageView.kf.setImage(with: url)
        teamNameLabel.text = teamName
        sportLabel.text = sport
        
    }
    
    // dismiss view
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
