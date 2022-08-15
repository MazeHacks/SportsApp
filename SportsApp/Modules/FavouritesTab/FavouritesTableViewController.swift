//
//  FavouritesTableViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 15/06/2022.
//

import UIKit
import Kingfisher
import CoreData
import Network

class FavouritesTableViewController: UITableViewController {
    
    private let favouritesViewModel = FavouritesViewModel()
    private let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering Cell
        let nibCell = UINib(nibName: K.LeaguesScreen.leagueCellNibName, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: K.LeaguesScreen.leagueCellIdentifier)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesViewModel.favouritesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.LeaguesScreen.leagueCellIdentifier, for: indexPath) as? LeagueCell else { fatalError() }
        
        let league = favouritesViewModel.favouritesList[indexPath.row]
        
        // Configuring the cell
        cell.leagueNameLabel.text = league.strLeague
        let url = URL(string: league.strBadge ?? "")
        cell.leagueBadgeImageView.kf.setImage(with: url)
        cell.youTubeLink = "https://" + (league.strYoutube ?? "www.google.com/")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let league = favouritesViewModel.favouritesList[indexPath.row]
        
        // Check internet connectivity
        self.monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .unsatisfied {
                print("Internet connection is on.")
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let destinationVC = storyBoard.instantiateViewController(withIdentifier: K.LeaguesDetails.leaguesDetailsScreenIdentifier) as! LeaguesDetailsViewController
                destinationVC.league = league
                guard destinationVC.league?.idLeague != nil else { return }
                destinationVC.modalPresentationStyle = .fullScreen
                self.present(destinationVC, animated: true)
            } else {
                print("There's no internet connection.")
                let alert = UIAlertController(title: "", message: "No internet connection", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "dismiss", style: .cancel)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
        self.monitor.start(queue: DispatchQueue.main)
        
    }
    
}
