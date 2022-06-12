//
//  JSONModels.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

//MARK: - SportsTab Models
struct Sport: Codable {
    
    var strSport: String?
    var strSportThumb: String?

}

struct Sports: Codable {
    var sports: [Sport]
}



//MARK: - LeaguesView Models
struct League: Codable {
    
    var strLeague: String?
    var strBadge: String?
    var strYoutube: String?
    var idLeague: String?
}

struct Leagues: Codable {
    var countries: [League]
}



//MARK: - LeaguesDetails Models
// Events Model
struct Event: Codable {
    
    var strEvent: String?
    var dateEvent: String?
    var strTime: String?
}

struct Events: Codable {
    var events: [Event]
}

// Teams Model
struct Team: Codable {
    var strTeamBadge: String?
}

struct Teams: Codable {
    var teams: [Team]
}
