//
//  Constants.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

struct K {
    
    // General
    static let noPictureAvailableIconName = "no-picture-available-icon"
    
    // SportsTab Constants
    struct sportsTab {
        static let sportCellIdentifier = "sportCell"
        static let sportsListApiUrl = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        static let sportCellNibName = "SportsCell"
    }
    
    // LeaguesScreen Constants
    struct LeaguesScreen {
        static let leagueCellIdentifier = "leagueCell"
        static let leaguesListApiUrl = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
        static let leagueCellNibName = "LeagueCell"
        static let leaguesScreenIdentifier = "LeaguesTableViewController"
    }
    
    // LeaguesDetailsView Constants
    struct LeaguesDetails {
        
        // Screen Identifier
        static let leaguesDetailsScreenIdentifier = "LeaguesDetailsCollectionViewController"
        
        // Upcoming Events CollectionView Constants
        static let eventCellIdentifier = "eventCell"
        static let eventCelllNibName = "EventCell"
        static let eventsListApiUrl = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
        
        // Latest Results CollectionView Constants
        static let latestResultCellIdentifier = "latestResultCell"
        static let latestResultCellNibName = "LatestResultsCell"

        // Teams CollectionView Constants
        static let teamCellIdentifier = "teamCell"
        static let teamCellNibName = "TeamsCell"
        static let teamsListApiUrl = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l="

    }

}
