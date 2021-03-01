//
//  FetchData.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/24/21.
//

import Foundation
import SwiftUI

struct NetworkService {
    let iTunesSearchEndpoint = "https://itunes.apple.com/search?term="
    
    func fetchTrackData(searchTerm: String, completion: @escaping (Result<[Track], Error>) -> Void) {
        let searchString = searchTerm.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: iTunesSearchEndpoint + searchString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                completion(self.parse(data: data, error: error))
            }
        }
        task.resume()
    }
    
    func parse(data: Data?, error: Error?) -> Result<[Track], Error> {
            if let data = data {
                return Result { try JSONDecoder().decode(TrackResponse.self, from: data).results }
            } else {
                return .failure(error ?? URLError(.badServerResponse))
            }
    }
}
