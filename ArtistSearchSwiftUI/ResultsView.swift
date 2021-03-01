//
//  ResultsView.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/25/21.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var isPresented: Bool     // The modal view with track list is presented
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                VStack {
                    Button(action: {
                        self.isPresented = false   // Setting isPresented to false will dismiss the track list
                    }, label: {
                        Text("Dismiss")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                            .font(.title)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                            .background(Color.white)
                    })
                    .cornerRadius(10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    List(viewModel.tracks) { track in
                        HStack {
                            Text(track.artistName ?? "")
                            VStack(alignment: .leading) {
                                Text(track.trackName ?? "")
                                Text(track.releaseDate ?? "")
                                Text(track.primaryGenreName ?? "")
                                Text(String(format: "%.2f", track.trackPrice ?? 0.0))
                            }
                        }
                    }
                }
            }
        }
    }
}

