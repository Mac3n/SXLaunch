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

    init(doc: Doc) {
        self.doc = doc
        getRocketInfo()
        
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


    func getRocketInfo() {
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
}
