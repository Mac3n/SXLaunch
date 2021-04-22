//
//  LaunchModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/22/21.
//

import Foundation


// MARK: - LaunchModel
struct LaunchModel: Decodable {
    let docs: [Doc]
    let totalDocs, limit, totalPages, page: Int
    let pagingCounter: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage, nextPage: Int
}

// MARK: - Doc
struct Doc: Decodable {
    let links: Links
    let staticFireDateUTC: String
    let staticFireDateUnix: Int
    let tbd, net: Bool
    let window: Int
    let rocket: String
    let success: Bool
    let details: String?
    let ships, capsules, payloads: [String]
    let launchpad: String
    let autoUpdate: Bool
    let failures: [Failure]
    let flightNumber: Int
    let name, dateUTC: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let id: String

    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd, net, window, rocket, success, details, ships, capsules, payloads, launchpad
        case autoUpdate = "auto_update"
        case failures
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
    let core: String
    let flight: Int
    let gridfins, legs, reused, landingAttempt: Bool
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

enum DatePrecision: String, Decodable {
    case hour = "hour"
}

// MARK: - Failure
struct Failure: Decodable {
    let time, altitude: Int
    let reason: String
}


// MARK: - Links
struct Links: Decodable {
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String
    let webcast: String
    let youtubeID: String
    let article: String
    let wikipedia: String

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Decodable {
    let small: [String]
    let original: [String]
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String
}

// MARK: - Reddit
struct Reddit: Decodable {
    let campaign: String?
    let launch: String
    let media: String
    let recovery: String?
}

