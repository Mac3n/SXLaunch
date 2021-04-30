//
//  LaunchDetailViewModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/30/21.
//

import Combine
import Foundation

class LaunchDetailViewModel: ObservableObject {

    private var doc: Doc
    @Published var galleryItem: URL?
    @Published var launchTilte = ""
    @Published var showHeaderImage = false
    @Published var logoURL: URL?
    @Published var launchDetails = ""
    @Published var launchStatus : Bool?
    @Published var launchData: String = ""
    @Published var rocketInfo: RocketInfoModel?
    @Published var launchpadInfo: LaunchpadModel?
    @Published var landpadInfo: LandpadModel?

    init(doc: Doc) {
        self.doc = doc
        getRocketInfo()
        getLaunchpadInfo()
        getLandpadInfo()
        
        galleryItem = doc.links?.flickr?.original?.compactMap { URL(string: $0) }.randomElement()
        launchTilte = doc.name ?? ""
        showHeaderImage = galleryItem != nil
        if let logoStr = doc.links?.patch?.small {
            logoURL = URL(string: logoStr)
        }
        launchDetails = doc.details ?? ""
        launchStatus = doc.success
        launchData = (doc.dateUnix ?? 0).formattedDate()
    }


    private func getRocketInfo() {
        guard let rocketID = doc.rocket else {
            return
        }
        SpaceXAPI.getRocketInfo(id: rocketID)
            .receive(on: DispatchQueue.main)
            .map { response in
                return response
            }
            .catch { _ in
                Just(self.rocketInfo)
            }
            .assign(to: &$rocketInfo)
    }

    private func getLaunchpadInfo() {
        guard let launchpadID = doc.launchpad else {
            return
        }
        SpaceXAPI.getLaunchpad(id: launchpadID)
            .receive(on: DispatchQueue.main)
            .map { response in
                return response
            }
            .catch { _ in
                Just(self.launchpadInfo)
            }
            .assign(to: &$launchpadInfo)
    }

    private func getLandpadInfo() {
        guard let landpadID = doc.cores?.first?.landpad else {
            return
        }
        SpaceXAPI.getLandpad(id: landpadID)
            .receive(on: DispatchQueue.main)
            .map { response in
                return response
            }
            .catch { _ in
                Just(self.landpadInfo)
            }
            .assign(to: &$landpadInfo)
    }
}
