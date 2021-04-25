//
//  LaunchModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/22/21.
//

import Foundation


// MARK: - LaunchModel
struct LaunchModel: Decodable {
    let docs: [Doc]?
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage, nextPage: Int?
}

// MARK: - Doc
struct Doc: Decodable, Identifiable {
    let id: String?
    let fairings: Fairings?
    let links: Links?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let tbd, net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
    let details: String?
    let crew, ships, capsules, payloads: [String]?
    let launchpad: String?
    let autoUpdate: Bool?
    let flightNumber: Int?
    let name, dateUTC: String?
    let dateUnix: Int?
    let dateLocal, datePrecision: String?
    let upcoming: Bool?
    let cores: [Core]?

    enum CodingKeys: String, CodingKey {
        case fairings, links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd, net, window, rocket, success, details, crew, ships, capsules, payloads, launchpad
        case autoUpdate = "auto_update"
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, cores, id
    }
}

// MARK: - Core
struct Core: Decodable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType, landpad: String?

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}

// MARK: - Fairings
struct Fairings: Decodable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [String]?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ships
    }
}

// MARK: - Links
struct Links: Decodable {
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article, wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Decodable {
    let small: [String]?
    let original: [String]?
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String?
}

// MARK: - Reddit
struct Reddit: Decodable {
    let campaign, launch: String?
    let media, recovery: String?
}
