//
//  ViewModel.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/25/21.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    @Published var tracks = [Track]()
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

