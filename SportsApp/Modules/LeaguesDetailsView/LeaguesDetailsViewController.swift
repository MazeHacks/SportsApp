//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import UIKit

class LeaguesDetailsViewController: UIViewController {

    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    private let leaguesDetailsViewModel = LeaguesDetailsViewModel()

    var leagueID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        upcomingEventsCollectionView.register(nibCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)

        upcomingEventsCollectionView.dataSource = self
        latestResultsCollectionView.dataSource = self
        teamsCollectionView.dataSource = self
        
        // Fetching data from API and Updating Collection View
        leaguesDetailsViewModel.getEvents(of: self.leagueID!)
        leaguesDetailsViewModel.eventsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.upcomingEventsCollectionView.reloadData()
            }
        }
        
    }

}

//MARK: - UICollectionView DataSource Methods

extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leaguesDetailsViewModel.eventsList.value?.events.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.eventCellIdentifier, for: indexPath) as? EventCell else { fatalError() }
        
        let event = leaguesDetailsViewModel.eventsList.value?.events[indexPath.item]
        cell.eventNameLabel.text = event?.strEvent
        cell.eventDateLabel.text = event?.dateEvent
        cell.eventTimeLabel.text = event?.strTime
        
        return cell
    }
    
}
