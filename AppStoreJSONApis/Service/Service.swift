//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 04.06.2022.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    // MARK: - Search Controller
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        print("Fetching iTunes Apps from Service layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("Failed to fetch app", err)
                completion([], nil)
                return
            }
            
            // succes
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
            } catch let jsonErr{
                print("Failed to decode json:", jsonErr)
            }
            
        }.resume() // fires off the request
    }
    
    // MARK: - Apps Controller
    func fetchTopFreeApps(completion: @escaping (AppsGroupResult?, Error?) -> ()) {        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    func fetchTopMusicAlbums(completion: @escaping (AppsGroupResult?, Error?) -> ()) {        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json"
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    func fetchTopPodcasts(completion: @escaping (AppsGroupResult?, Error?) -> ()) {        let urlString = "https://rss.applemarketingtools.com/api/v2/us/podcasts/top/25/podcasts.json"
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    // helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppsGroupResult?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppsGroupResult.self, from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
            
        }.resume()
        
    }
}

