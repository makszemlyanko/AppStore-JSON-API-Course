//
//  MusicResult.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 06.09.2022.
//

import Foundation

struct MusicResult: Codable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Codable {
    let artistName: String
    let trackName: String?
    let artworkUrl100: String
    let collectionName: String?
}
