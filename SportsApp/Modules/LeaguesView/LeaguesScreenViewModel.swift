//
//  LeaguesScreenViewModel.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import Foundation

class LeaguesScreenViewModel {
    
    var leaguesList: Observable<Leagues> = Observable(nil)
    
    //Calling API Service
    func getLeagues(of sport: String) {
        APIService.shared.fetchLeagues(from: K.LeaguesScreen.leaguesListApiUrl+sport, completionHandler: { result in
            DispatchQueue.main.async {
                self.leaguesList.value = result
            }
        })
    }
    
}
