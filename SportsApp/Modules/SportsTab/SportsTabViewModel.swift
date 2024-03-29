//
//  SportsTabViewModel.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

class SportsTabViewModel {
    
    var sportsList: Observable<Sports> = Observable(nil)
    
    //Calling API Service
    func getSports() {
        APIService.shared.fetchSports(from: K.sportsTab.sportsListApiUrl, completionHandler: { result in
            DispatchQueue.main.async {
                self.sportsList.value = result
            }
        })
    }
    
}
