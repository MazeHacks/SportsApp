//
//  sportsCollectionViewController.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import UIKit
import Kingfisher

class sportsCollectionViewController: UICollectionViewController {
    
    private let sportsTabViewModel = SportsTabViewModel()
    private var leaguesScreenViewModel = LeaguesScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering cell
        let nibCell = UINib(nibName: K.sportsTab.sportCellNibName, bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: K.sportsTab.sportCellIdentifier)
        
        // Setting up collectionViewFlowLayout
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Fetching data from API and Updating Collection View
        sportsTabViewModel.getSports()
        sportsTabViewModel.sportsList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsTabViewModel.sportsList.value?.sports.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.sportsTab.sportCellIdentifier, for: indexPath) as? SportsCell else { fatalError() }
        
        let sport = sportsTabViewModel.sportsList.value?.sports[indexPath.item]
        
        // Configure the cell
        let url = URL(string: sport?.strSportThumb ?? "")
        cell.sportsImageView.kf.setImage(with: url, placeholder: UIImage(named: K.noPictureAvailableIconName))
        cell.sportNameLabel.text = sport?.strSport
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sport = sportsTabViewModel.sportsList.value?.sports[indexPath.item]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: K.LeaguesScreen.leaguesScreenIdentifier) as! LeaguesTableViewController
        destinationVC.sport = sport?.strSport
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout Methods

extension sportsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width/2, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
