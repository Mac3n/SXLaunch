//
//  LaunchListViewModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/26/21.
//

import Combine
import Foundation

class LaunchListViewModel: ObservableObject {

    @Published var docs = [Doc]()
    @Published var isLoading = false

    private var currentPage = 1
    private var limitPerPage = 20
    private var canLoadMorePage = true

    init() {
        fetchLaunches()
    }

    func loadNextPage(currentItem doc: Doc?) {
        guard let doc = doc else {
            fetchLaunches()
            return
        }

        let offsetIndex = docs.index(docs.endIndex, offsetBy: -5)
        if docs.firstIndex(where: { $0.id == doc.id}) == offsetIndex {
            fetchLaunches()
        }
    }

    private func fetchLaunches() {
        guard !isLoading, canLoadMorePage else {
            return
        }
        isLoading = true
        SpaceXAPI.launches(query: [
            "query": [
                "upcoming": false
            ],
            "options": [
                "limit": limitPerPage,
                "page": currentPage
            ]
        ])
        //.print()
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveOutput: { response in
            self.canLoadMorePage = response.hasNextPage ?? false
            self.isLoading = false
            self.currentPage += 1
        })
        .map { response in
            return self.docs + (response.docs ?? [])
        }
        .catch { _ in
            Just(self.docs)
        }
        .assign(to: &$docs)
    }
}
