//
//  Reviews.swift
//  AppStoreJSONApis
//
//  Created by Maks Kokos on 21.06.2022.
//

import UIKit

struct Reviews: Decodable {
    let feed: ReviewsFeed
}

struct ReviewsFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let label: String
    let name: Label
}
