//
//  JSONModels.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

struct Sport: Codable {
    
    var strSport: String?
    var strSportThumb: String?

}

struct League: Codable {
    
    var strLeague: String?
    var strBadge: String?
    var strYoutube: String?
    
}

struct Sports: Codable {
    var sports: [Sport]
}

struct Leagues: Codable {
    var countries: [League]
}
