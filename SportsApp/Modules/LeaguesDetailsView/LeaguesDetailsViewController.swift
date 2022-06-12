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
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cells for the 3 collection views
        let eventCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        upcomingEventsCollectionView.register(eventCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        let resultCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        latestResultsCollectionView.register(resultCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        let teamCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        teamsCollectionView.register(teamCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        
        // Setting up collectionViewFlowLayout
        latestResultsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        upcomingEventsCollectionView.collectionViewLayout = layout
        teamsCollectionView.collectionViewLayout = layout

        // Setting dataSources for CollectionViews
        upcomingEventsCollectionView.dataSource = self
        latestResultsCollectionView.dataSource = self
        teamsCollectionView.dataSource = self
        
        // Setting delegate for collectionViews
        upcomingEventsCollectionView.delegate = self
        latestResultsCollectionView.delegate = self
        teamsCollectionView.delegate = self
        
        // Fetching data from API and Updating each Collection View
        leaguesDetailsViewModel.getEvents(of: self.leagueID!)
        leaguesDetailsViewModel.eventsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.upcomingEventsCollectionView.reloadData()
//                self?.latestResultsCollectionView.reloadData()
//                self?.teamsCollectionView.reloadData()
            }
        }
        
    }

}

//MARK: - UICollectionView DataSource Methods

extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leaguesDetailsViewModel.eventsList.value?.events.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.eventCellIdentifier, for: indexPath) as? EventCell else { fatalError() }
        
        let N = leaguesDetailsViewModel.eventsList.value?.events.count
        let event = leaguesDetailsViewModel.eventsList.value?.events[indexPath.item]

        if N == nil {
            cell.eventNameLabel.text = "No Upcoming Events!"
            cell.eventDateLabel.isHidden = true
            cell.eventTimeLabel.isHidden = true
        } else {
            cell.eventDateLabel.isHidden = false
            cell.eventTimeLabel.isHidden = false
            cell.eventNameLabel.text = event?.strEvent
            cell.eventDateLabel.text = event?.dateEvent
            cell.eventTimeLabel.text = event?.strTime
        }
        
        return cell
    }
    
}

//MARK: - UICollectionView FlowLayout Methods

extension LeaguesDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
