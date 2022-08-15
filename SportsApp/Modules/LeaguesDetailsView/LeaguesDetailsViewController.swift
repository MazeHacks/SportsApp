//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import UIKit
import Kingfisher

class LeaguesDetailsViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var upcomingEventsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultsCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    private let leaguesDetailsViewModel = LeaguesDetailsViewModel()
    private var favouritesViewModel = FavouritesViewModel()
    
    var league: League?

    @IBOutlet weak var collectionViews: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cells for the 3 collection views
        let eventCell = UINib(nibName: K.LeaguesDetails.eventCelllNibName, bundle: nil)
        upcomingEventsCollectionView.register(eventCell, forCellWithReuseIdentifier: K.LeaguesDetails.eventCellIdentifier)
        let resultCell = UINib(nibName: K.LeaguesDetails.latestResultCellNibName, bundle: nil)
        latestResultsCollectionView.register(resultCell, forCellWithReuseIdentifier: K.LeaguesDetails.latestResultCellIdentifier)
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
        leaguesDetailsViewModel.getEvents(of: (self.league?.idLeague)!)
        leaguesDetailsViewModel.eventsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.upcomingEventsCollectionView.reloadData()
            }
        }
        
        // Fetching Latest Results from API and Updating Collection View
        leaguesDetailsViewModel.resultsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.latestResultsCollectionView.reloadData()
            }
        }
        
        // Fetching Teams from API and Updating Collection View
        let league = league?.strLeague?.replacingOccurrences(of: " ", with: "%20")
        leaguesDetailsViewModel.getTeams(in: league!)
        leaguesDetailsViewModel.teamsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.teamsCollectionView.reloadData()
            }
        }
        
    }
    
    // Adding current league to favourites
    @IBAction func addToFavourites(_ sender: Any) {

        print("League added!")
        
    }
    
    // dismiss view
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
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
            return leaguesDetailsViewModel.resultsList.value?.events.count ?? 1
        } else {
            return leaguesDetailsViewModel.teamsList.value?.teams.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Conditions for returned cells based on collectionView
        if collectionView == upcomingEventsCollectionView {
            
            guard let eventCell = upcomingEventsCollectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.eventCellIdentifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
            upcomingEventsCollectionView.backgroundColor = .white
            let event = leaguesDetailsViewModel.eventsList.value?.events[indexPath.item]
            
            eventCell.eventNameLabel.text = event?.strEvent
            eventCell.eventDateLabel.text = event?.dateEvent
            eventCell.eventTimeLabel.text = event?.strTime
            
            return eventCell
            
        } else if collectionView == latestResultsCollectionView {
            
            guard let latestResultCell = latestResultsCollectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.latestResultCellIdentifier, for: indexPath) as? LatestResultsCell else { return UICollectionViewCell() }
            latestResultsCollectionView.backgroundColor = .white
            let result = leaguesDetailsViewModel.resultsList.value?.events[indexPath.item]
            
            latestResultCell.dateLabel.text = result?.dateEvent
            latestResultCell.timeLabel.text = result?.strTime
            latestResultCell.homeTeamLabel.text = result?.strHomeTeam
            latestResultCell.awayTeamLabel.text = result?.strAwayTeam
            latestResultCell.homeScoreLabel.text = result?.intHomeScore
            latestResultCell.awayScoreLabel.text = result?.intAwayScore
            
            return latestResultCell
            
        } else {
            
            guard let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LeaguesDetails.teamCellIdentifier, for: indexPath) as? TeamsCell else { return UICollectionViewCell() }
            teamsCollectionView.backgroundColor = .white
            let team = leaguesDetailsViewModel.teamsList.value?.teams[indexPath.item]
            let url = URL(string: team?.strTeamBadge ?? "")
            teamCell.teamBadgeImageView.kf.setImage(with: url, placeholder: UIImage(named: K.noPictureAvailableIconName))
            teamCell.teamBadgeImageView.layer.cornerRadius = teamCell.teamBadgeImageView.bounds.height/2
            
            return teamCell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == teamsCollectionView {
            
            let team = leaguesDetailsViewModel.teamsList.value?.teams[indexPath.item]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyBoard.instantiateViewController(withIdentifier: K.leaguesDetailsScreenIdentifier) as! TeamDetailsViewController
            destinationVC.sport = team?.strSport
            destinationVC.teamName = team?.strTeam
            destinationVC.teamBadge = team?.strTeamBadge
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true)

        }
    }
    
}

//MARK: - UICollectionView FlowLayout Methods

extension LeaguesDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var returned: CGSize
        if collectionView == upcomingEventsCollectionView {
            returned = CGSize(width: upcomingEventsCollectionView.frame.width, height: upcomingEventsCollectionView.frame.height/3)
        } else if collectionView == teamsCollectionView {
            returned = CGSize(width: teamsCollectionView.frame.height, height: teamsCollectionView.frame.height)
        } else {
            returned = CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
        }
        return returned
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
