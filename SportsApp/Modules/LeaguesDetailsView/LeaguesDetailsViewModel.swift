//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import Foundation

struct LeaguesDetailsViewModel {
    
    var eventsList: Observable<Events> = Observable(nil)
    
    //Calling API Service
    func getEvents(of league: String) {
        APIService.shared.fetchEvents(from: K.LeaguesDetails.eventsListApiUrl+league, completionHandler: { result in
            DispatchQueue.main.async {
                eventsList.value = result
            }
        })
    }
    
}
