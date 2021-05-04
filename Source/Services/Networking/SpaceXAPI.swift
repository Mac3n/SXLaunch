//
//  SpaceXAPI.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/23/21.
//

import Combine
import Foundation

typealias Query = [String: Any]

enum SpaceXAPI {
    static let network = NetworkProvider()
    static let baseURL = URL(string: "https://api.spacexdata.com/v4")!

    case query(query: Query)
}

/*
 ✅ If the api endpoints are more complicated and having many diffrent APIs,
 we could implement the generic Network with protocls that handle the request
 build depend on the endpoint type and inputs.
 */

 extension SpaceXAPI {
    static func launches(query: Query) -> AnyPublisher<LaunchModel, Error> {
        var request = URLRequest(url: baseURL.appendingPathComponent("/launches/query"))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
        request.httpMethod = "POST"
        return network.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func getLaunchpad(id: String) -> AnyPublisher<LaunchpadModel, Error> {
        let request = URLRequest(url: baseURL.appendingPathComponent("/launchpads/\(id)"))
        return network.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func getLandpad(id: String) -> AnyPublisher<LandpadModel, Error> {
        let request = URLRequest(url: baseURL.appendingPathComponent("/landpads/\(id)"))
        return network.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func getRocketInfo(id: String) -> AnyPublisher<RocketInfoModel, Error> {
        let request = URLRequest(url: baseURL.appendingPathComponent("/rockets/\(id)"))
        return network.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
