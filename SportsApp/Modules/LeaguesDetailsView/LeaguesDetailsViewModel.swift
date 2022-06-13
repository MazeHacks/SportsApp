//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Moataz Hussein on 09/06/2022.
//

import Foundation
import UIKit

struct LeaguesDetailsViewModel {
    
    var eventsList: Observable<Events> = Observable(nil)
    var resultsList: Observable<Events> = Observable(nil)
    var teamsList: Observable<Teams> = Observable(nil)
    
    // Fetching Upcoming Events
    func getEvents(of league: String) {
        APIService.shared.fetchEvents(from: K.LeaguesDetails.eventsListApiUrl+league, completionHandler: { result in
            DispatchQueue.main.async {
                eventsList.value = result
                resultsList.value = result
                filterEvents()
            }
        
        })
    
    }
    
    func filterEvents() {
        guard let events = eventsList.value?.events else { return }
        let dateFormatter = ISO8601DateFormatter()
        let n = eventsList.value?.events.count ?? 0
        for i in (0 ..< n).reversed() {
            if let eventDate = events[i].dateEvent, var eventTime = events[i].strTime {
                if eventTime.count < 8 {
                    eventTime = "00:00:00"
                }
                if !eventDate.isEmpty {
                    let isoDate = eventDate+"T"+eventTime+"+00:00"
                    let date = dateFormatter.date(from:isoDate)!
                    if date < Date() {
                        eventsList.value?.events.remove(at: i)
                    }
                    
                }
                
            }
                
        }
    }
    
    // Fetching Teams
    func getTeams(in league: String) {
        APIService.shared.fetchTeams(from: K.LeaguesDetails.teamsListApiUrl+league) { result in
            DispatchQueue.main.async {
                teamsList.value = result
            }
        }
    }
}
