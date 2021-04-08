//
//  FetchData.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/24/21.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case domainError
    case decodingError
}

struct NetworkService {
    let iTunesSearchEndpoint = "https://itunes.apple.com/search?term="
    
    func fetchTrackData(searchTerm: String, completion: @escaping (Result<[Track], NetworkError>) -> Void) {
        let searchString = searchTerm.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: iTunesSearchEndpoint + searchString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            
            do {
                let tracks = try JSONDecoder().decode(TrackResponse.self, from: data).results
                DispatchQueue.main.async {
                    completion(.success(tracks))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            } catch {
                print("error: ", error)
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
        task.resume()
    }
}
