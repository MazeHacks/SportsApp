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

        // Register cell classes
        let nibCell = UINib(nibName: K.leagueCellNibName, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: K.leagueCellIdentifier)
        
        // Fetching data from API and Updating Collection View
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

        if N == nil {
            
            cell.leagueNameLabel.text = "No Leagues Available for \(sport!)!"

            
        } else {
            // Configure the cell...
            let url = URL(string: leaguesScreenViewModel.leaguesList.value?.countries[indexPath.row].strBadge ?? "https://www.dreamstime.com/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-image132482953")
            cell.leagueBadgeImageView.kf.setImage(with: url)
            cell.leagueBadgeImageView.layer.cornerRadius = cell.leagueBadgeImageView.bounds.height/2
            cell.leagueNameLabel.text = leaguesScreenViewModel.leaguesList.value?.countries[indexPath.row].strLeague
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
