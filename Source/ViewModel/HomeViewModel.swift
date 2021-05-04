//
//  HomeViewModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/22/21.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {

    @Published var doc: Doc?
    @Published var countDownDays = ""
    @Published var countDownHours = ""
    @Published var countDownMinutes = ""
    @Published var countDownSeconds = ""

    private var launchUnixDate: Int = 0
    private var timer: Timer?

    init() {
        getNextLaunch()
    }

    func getNextLaunch() {
        SpaceXAPI.launches(query: [
            "query": [
                "upcoming": true
            ],
            "options": [
                "limit": 1,
                "page": 1,
                "sort": [
                    "flight_number": "asc"
                ]
            ]
        ])
        .receive(on: DispatchQueue.main)
        .map { $0.docs?.last }
        .handleEvents(receiveOutput: { doc in
            guard let time = doc?.dateUnix else {
                return
            }
            self.launchUnixDate = time
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
            self.timer?.fire()
        })
        .catch { _ in
            Just(self.doc)
        }
        .assign(to: &$doc)
    }

    @objc func countdown() {
        let components = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: Date(), to: Date(timeIntervalSince1970: TimeInterval(launchUnixDate)))
        countDownDays = "\(components.day ?? 0)"
        countDownHours = "\(components.hour ?? 0)"
        countDownMinutes = "\(components.minute ?? 0)"
        countDownSeconds = "\(components.second ?? 0)"
    }
}
