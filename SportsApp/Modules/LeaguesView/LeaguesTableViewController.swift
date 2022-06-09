//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    private let leaguesScreenViewModel = LeaguesScreenViewModel()
    var sport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Registering cell
        let nibCell = UINib(nibName: K.leagueCellNibName, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: K.leagueCellIdentifier)
        
        // Fetching data from API and Updating Table View
        leaguesScreenViewModel.getLeagues(of: self.sport!)
        leaguesScreenViewModel.leaguesList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesScreenViewModel.leaguesList.value?.countries.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.leagueCellIdentifier, for: indexPath) as? LeagueCell else { fatalError() }
        
        let N = leaguesScreenViewModel.leaguesList.value?.countries.count
        let currentLeague = leaguesScreenViewModel.leaguesList.value?.countries[indexPath.row]

        if N == nil {
            
            cell.leagueNameLabel.text = "No Leagues Available for \(sport!)!"
            cell.leagueNameLabel.textAlignment = .center
            cell.youTubeButton.isHidden = true
            cell.leagueBadgeImageView.isHidden = true

            
        } else {
            cell.youTubeButton.isHidden = false
            cell.leagueBadgeImageView.isHidden = false
            cell.leagueNameLabel.textAlignment = .left
            // Configurig the cell
            let url = URL(string: currentLeague?.strBadge ?? "https://www.dreamstime.com/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-image132482953")
            cell.leagueBadgeImageView.kf.setImage(with: url)
            cell.leagueBadgeImageView.layer.cornerRadius = cell.leagueBadgeImageView.bounds.height/2
            cell.leagueNameLabel.text = currentLeague?.strLeague
            if currentLeague?.strYoutube == "" {
                cell.youTubeButton.isHidden = true
            }
            cell.youTubeLink = "https://" + (currentLeague?.strYoutube ?? "www.google.com/")
        }

        return cell
    }

}
