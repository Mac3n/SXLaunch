//
//  LandpadModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 5/1/21.
//

import Foundation


// MARK: - LandingpadModel
struct LandpadModel: Codable {
    let name, fullName, type, locality: String?
    let region: String?
    let latitude, longitude: Double?
    let landingAttempts, landingSuccesses: Int?
    let wikipedia: String?
    let details: String?
    let launches: [String]?
    let status, id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case type, locality, region, latitude, longitude
        case landingAttempts = "landing_attempts"
        case landingSuccesses = "landing_successes"
        case wikipedia, details, launches, status, id
    }
}
