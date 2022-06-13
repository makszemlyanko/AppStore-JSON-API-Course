//
//  AppsGroupResult.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 10.06.2022.
//

import UIKit

struct AppsGroupReuslt: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let result: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
