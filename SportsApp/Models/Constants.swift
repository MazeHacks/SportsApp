//
//  Constants.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

struct K {
    
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
        static let eventCellIdentifier = "eventCell"
        static let latestResultCellIdentifier = "latestResultCell"
        static let teamCellIdentifier = "teamCell"
    }

}
