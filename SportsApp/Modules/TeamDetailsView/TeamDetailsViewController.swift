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
        
        // Adding double tap gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDoubleTapped(_:)))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        self.view.isUserInteractionEnabled = true
        
    }

    // Gesture recognizer method
    @objc func viewDoubleTapped(_ gesture: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}
