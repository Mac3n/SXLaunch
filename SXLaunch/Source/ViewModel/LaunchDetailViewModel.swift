//
//  LaunchDetailViewModel.swift
//  SXLaunch
//
//  Created by Mohsen Taabodi on 4/30/21.
//

import Foundation

class LaunchDetailViewModel: ObservableObject {

    var doc: Doc

    init(doc: Doc) {
        self.doc = doc
    }

    func getHeaderImageURL() -> URL? {
        guard let imageURLString = doc.links?.flickr?.original?.first, let imageURL = URL(string: imageURLString) else {
            return nil
        }
        return imageURL
    }

}
