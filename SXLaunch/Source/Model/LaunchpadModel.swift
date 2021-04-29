//
//  LaunchpadModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/29/21.
//

import Foundation

// MARK: - LaunchpadModel
struct LaunchpadModel: Codable {
    let name, fullName, status, type: String?
    let locality, region: String?
    let latitude, longitude: Double?
    let landingAttempts, landingSuccesses: Int?
    let wikipedia: String?
    let details: String?
    let launches: [String]?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case status, type, locality, region, latitude, longitude
        case landingAttempts = "landing_attempts"
        case landingSuccesses = "landing_successes"
        case wikipedia, details, launches, id
    }
}
