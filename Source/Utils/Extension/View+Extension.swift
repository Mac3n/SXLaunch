//
//  View+Extension.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/26/21.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
