//
//  ArtistSearchSwiftUITests.swift
//  ArtistSearchSwiftUITests
//
//  Created by David Lindsay on 2/24/21.
//

import XCTest
import SwiftUI
@testable import ArtistSearchSwiftUI

class ArtistSearchSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownloadSongTracks() {
        
        let expectation = XCTestExpectation(description: "Search for artist on iTunes and download related track data.")
        let sut = NetworkService()
        
        var result: Result<[Track], Error>?
        var testTracks = [Track]()
        
        sut.fetchTrackData(searchTerm: "Allman Brothers") {
            result = $0
            expectation.fulfill()
            switch result {
            case .success(let data):
                testTracks = data
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertGreaterThan(testTracks.count, 20)
    }

}
