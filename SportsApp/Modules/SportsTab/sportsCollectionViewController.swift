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
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
