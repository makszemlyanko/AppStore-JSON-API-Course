//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 03.06.2022.
//

import Foundation


struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    var screenshotUrls: [String]
    let artworkUrl100: String // app icon
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
}
