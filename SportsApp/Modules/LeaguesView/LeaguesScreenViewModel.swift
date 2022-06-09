//
//  LeaguesScreenViewModel.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import Foundation

struct LeaguesScreenViewModel {
    
    var leaguesList: Observable<Leagues> = Observable(nil)
    
    //Calling API Service
    func getLeagues(of sport: String) {
        APIService.shared.fetchLeagues(from: K.leaguesListApiUrl+sport, completionHandler: { result in
            DispatchQueue.main.async {
                leaguesList.value = result
            }
        })
    }
    
}
