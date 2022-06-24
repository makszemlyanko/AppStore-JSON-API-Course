//
//  AppsGroupResult.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 10.06.2022.
//

import Foundation

struct AppsGroupResult: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}
