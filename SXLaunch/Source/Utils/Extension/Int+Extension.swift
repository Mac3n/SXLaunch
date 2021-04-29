//
//  Int+Extension.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/29/21.
//

import Foundation

extension Int {
    func formattedDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
