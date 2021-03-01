//
//  TrackResponse.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/24/21.
//

import Foundation

struct TrackResponse: Decodable {
    let results: [Track]
}
