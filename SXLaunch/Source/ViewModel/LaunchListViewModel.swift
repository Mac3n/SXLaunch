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
    @Published var selectedSection: SelectedSection = .latest

    private var currentPage = 1
    private var limitPerPage = 20
    private var getUpcomingLaunches = false
    private var canLoadMorePage = true
    private var sortOrder: SortOrder = .asc
    private var anyCancellable: Set<AnyCancellable> = []

    enum SelectedSection: Int {
        case all
        case latest
        case upcoming
    }

    enum SortOrder: String {
        case asc
        case desc
    }

    init() {
        $selectedSection
            .sink { [weak self] value in
                self?.canLoadMorePage = true
                self?.isLoading = false
                self?.currentPage = 1
                switch value {
                case .all:
                    self?.getUpcomingLaunches = false
                    self?.sortOrder = .asc
                case .upcoming:
                    self?.getUpcomingLaunches = true
                    self?.sortOrder = .asc
                case .latest:
                    self?.getUpcomingLaunches = false
                    self?.sortOrder = .desc
                }
                self?.docs.removeAll()
                self?.fetchLaunches()
            }.store(in: &anyCancellable)
    }

    func loadNextPage(currentItem doc: Doc?) {
        guard let doc = doc else {
            fetchLaunches()
            return
        }

        let offsetIndex = docs.index(docs.endIndex, offsetBy: -5)
        if docs.firstIndex(where: { $0.id == doc.id}) == offsetIndex && selectedSection == .all {
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
                "upcoming": getUpcomingLaunches
            ],
            "options": [
                "limit": limitPerPage,
                "page": currentPage,
                "sort": [
                    "flight_number": sortOrder.rawValue
                ]
            ]
        ])
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
