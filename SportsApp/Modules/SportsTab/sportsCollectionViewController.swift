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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        let nibCell = UINib(nibName: K.sportCellNibName, bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: K.sportCellIdentifier)
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.sportCellIdentifier, for: indexPath) as? SportsCell else { fatalError() }
        
        // Configure the cell
        let url = URL(string: sportsTabViewModel.sportsList.value?.sports[indexPath.item].strSportThumb ?? "")
        cell.sportsImageView.kf.setImage(with: url, placeholder: UIImage(named: "no-picture-available-icon"))
        cell.sportNameLabel.text = sportsTabViewModel.sportsList.value?.sports[indexPath.item].strSport
        
        return cell
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout Methods

extension sportsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
