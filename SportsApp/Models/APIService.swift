//
//  APIService.swift
//  SportsApp
//
//  Created by Moataz Hussein on 07/06/2022.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() {
        
    }
    
    func fetchSports(from api: String, completionHandler: @escaping (Sports?) -> Void) {
        
        if let url = URL(string: api) {
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(Sports.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Error!")
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func fetchLeagues(from api: String, completionHandler: @escaping (Leagues?) -> Void) {
        
        if let url = URL(string: api) {
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(Leagues.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Error!")
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func fetchEvents(from api: String, completionHandler: @escaping (Events?) -> Void) {
        
        if let url = URL(string: api) {
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(Events.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Error!")
                    }
                }
            }
            task.resume()
        }
        
    }
    
}
