//
//  HomeViewModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/22/21.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {

    private var anyCancellable: Set<AnyCancellable> = []

    init() {
        SpaceXAPI.launches(query: [:])
            .print()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { print($0) })
            .store(in: &anyCancellable)
    }
}
