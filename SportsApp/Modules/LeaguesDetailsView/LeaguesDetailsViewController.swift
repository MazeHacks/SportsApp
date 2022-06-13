//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import UIKit
import Kingfisher

class LeaguesDetailsViewController: UIViewController {
    
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    private let leaguesDetailsViewModel = LeaguesDetailsViewModel()
    
    var leagueID: String?
    var leagueName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding double tap gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDoubleTapped(_:)))
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        self.view.isUserInteractionEnabled = true
        
        // Registering cells for the 3 collection views
        let eventCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        upcomingEventsCollectionView.register(eventCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        let resultCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        latestResultsCollectionView.register(resultCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        let teamCell = UINib(nibName: K.LeaguesDetails.teamCellNibName, bundle: nil)
        teamsCollectionView.register(teamCell, forCellWithReuseIdentifier: K.LeaguesDetails.teamCellIdentifier)
        
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
        
        // Fetching Upcoming Events from API and Updating Collection View
        leaguesDetailsViewModel.getEvents(of: self.leagueID!)
        leaguesDetailsViewModel.eventsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.upcomingEventsCollectionView.reloadData()
                self?.latestResultsCollectionView.reloadData()
            }
        }
        
        // Fetching Teams from API and Updating Collection View
        let league = leagueName?.replacingOccurrences(of: " ", with: "%20")
        leaguesDetailsViewModel.getTeams(in: league!)
        leaguesDetailsViewModel.teamsList.bind { [weak self] teams in
            DispatchQueue.main.async {
                self?.teamsCollectionView.reloadData()
            }
        }
    }
    
    // Gesture recognizer method
    @objc func viewDoubleTapped(_ gesture: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}



//MARK: - UICollectionView DataSource Methods

extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Conditions for number of items returned based on collectionView
        if collectionView == self.upcomingEventsCollectionView {
            return leaguesDetailsViewModel.eventsList.value?.events.count ?? 1
        } else if collectionView == self.latestResultsCollectionView {
            return leaguesDetailsViewModel.eventsList.value?.events.count ?? 1
        } else if collectionView == self.teamsCollectionView {
            return leaguesDetailsViewModel.teamsList.value?.teams.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Conditions for returned cells based on collectionView
        if collectionView == upcomingEventsCollectionView {
            
            guard let eventCell = upcomingEventsCollectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.eventCellIdentifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
            
            let n = leaguesDetailsViewModel.eventsList.value?.events.count
            let event = leaguesDetailsViewModel.eventsList.value?.events[indexPath.item]
            
            if n == nil {
                eventCell.eventNameLabel.text = "No Upcoming Events!"
                eventCell.eventDateLabel.isHidden = true
                eventCell.eventTimeLabel.isHidden = true
            } else {
                eventCell.eventDateLabel.isHidden = false
                eventCell.eventTimeLabel.isHidden = false
                eventCell.eventNameLabel.text = event?.strEvent
                eventCell.eventDateLabel.text = event?.dateEvent
                eventCell.eventTimeLabel.text = event?.strTime
            }
            
            return eventCell
            
        } else if collectionView == latestResultsCollectionView {
            
            guard let eventCell = latestResultsCollectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.eventCellIdentifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
            
            let n = leaguesDetailsViewModel.eventsList.value?.events.count
            let event = leaguesDetailsViewModel.eventsList.value?.events[indexPath.item]
            
            if n == nil {
                eventCell.eventNameLabel.text = "No Upcoming Events!"
                eventCell.eventDateLabel.isHidden = true
                eventCell.eventTimeLabel.isHidden = true
            } else {
                eventCell.eventDateLabel.isHidden = false
                eventCell.eventTimeLabel.isHidden = false
                eventCell.eventNameLabel.text = event?.strEvent
                eventCell.eventDateLabel.text = event?.dateEvent
                eventCell.eventTimeLabel.text = event?.strTime
            }
            
            return eventCell
            
        } else {
            
            guard let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.teamCellIdentifier, for: indexPath) as? TeamsCell else { return UICollectionViewCell() }
            
            let team = leaguesDetailsViewModel.teamsList.value?.teams[indexPath.item]
            let url = URL(string: team?.strTeamBadge ?? "")
            teamCell.teamBadgeImageView.kf.setImage(with: url, placeholder: UIImage(named: K.noPictureAvailableIconName))
            teamCell.teamBadgeImageView.layer.cornerRadius = teamCell.teamBadgeImageView.bounds.height/2
            
            return teamCell
            
        }
        
    }
    
}

//MARK: - UICollectionView FlowLayout Methods

extension LeaguesDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var returned: CGSize
        if collectionView == upcomingEventsCollectionView {
            returned = CGSize(width: upcomingEventsCollectionView.bounds.width, height: upcomingEventsCollectionView.bounds.height/3)
        } else if collectionView == teamsCollectionView {
            returned = CGSize(width: teamsCollectionView.bounds.height, height: teamsCollectionView.bounds.height)
        } else {
            returned = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height/3)
        }
        return returned
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
