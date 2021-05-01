//
//  NetworkProvider.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/23/21.
//

import Combine
import Foundation

struct NetworkProvider {

    struct  Response<T> {
        let value: T
        let reposne: URLResponse
    }

    func fetch<T: Decodable>(_ request: URLRequest,
                             _ decoder: JSONDecoder = .init()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, reposne: result.response)
            }
            .eraseToAnyPublisher()
    }
}
