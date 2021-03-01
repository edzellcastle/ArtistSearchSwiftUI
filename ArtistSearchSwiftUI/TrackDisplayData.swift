//
//  TrackDisplayData.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/27/21.
//

import Foundation
import SwiftUI

struct TrackDisplayData: Identifiable {
    let id = UUID()
    var artistName: String?
    var trackName: String?
    var trackPrice: Double?
    var releaseDate: String?
    var primaryGenreName: String?
}
