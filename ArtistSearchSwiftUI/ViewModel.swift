//
//  ViewModel.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/25/21.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    @Published var tracks = [Track]() {
        didSet {
            let formatter = ISO8601DateFormatter()
            tracksDisplayData.removeAll()
            for track in tracks {
                var displayTrack = TrackDisplayData()
                displayTrack.artistName = track.artistName
                displayTrack.trackName = track.trackName
                displayTrack.trackPrice = String(format: "$%.2f", track.trackPrice ?? 0.0)
                displayTrack.primaryGenreName = track.primaryGenreName
                let date = formatter.date(from: track.releaseDate ?? "")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/YYYY"
                if let date = date {
                    displayTrack.releaseDate = dateFormatter.string(from: date)
                } else {
                    displayTrack.releaseDate = ""
                }
                tracksDisplayData.append(displayTrack)
            }
        }
    }
    @Published var tracksDisplayData = [TrackDisplayData]()
    @Published var isLoading = false
    
    var networkService: NetworkService
    var searchTerm = ""
    
    init() {
        networkService = NetworkService()
    }
    
    func updateSearchTerm(searchString: String) {
        self.searchTerm = searchString
    }
    
    func fetchTrackData() {
        isLoading = true
        networkService.fetchTrackData(searchTerm: searchTerm) { [weak self] result in
            switch result {
            case .success(let data):
                self?.tracks = data
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.isLoading = false
        }
    }
}
