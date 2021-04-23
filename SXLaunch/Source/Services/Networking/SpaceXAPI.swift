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
}

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
}
