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
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        print("Fetching iTunes Apps from Service layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // MARK: - Apps Controller
    func fetchTopFreeApps(completion: @escaping (AppsGroupResult?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopMusicAlbums(completion: @escaping (AppsGroupResult?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/25/albums.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPodcasts(completion: @escaping (AppsGroupResult?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/podcasts/top/25/podcasts.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // Helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppsGroupResult?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApps]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // Declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode: ", error)
            }
        }.resume()
    }
}

