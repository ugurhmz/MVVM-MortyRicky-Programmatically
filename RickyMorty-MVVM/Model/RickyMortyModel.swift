//
//  RickyMortyModel.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 17.03.2022.
//

import Foundation


// MARK: - PostModel
struct RickyGeneralModel: Codable {
    let info: Info?
    let results: [RickyInfo]?

    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}

// MARK: - Info
struct Info: Codable {
    let count: Int?
    let pages: Int?
    let next: String?

    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
    }
}

// MARK: - Result
struct RickyInfo: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
