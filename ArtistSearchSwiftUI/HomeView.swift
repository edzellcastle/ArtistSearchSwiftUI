//
//  HomeView.swift
//  ArtistSearchSwiftUI
//
//  Created by David Lindsay on 2/24/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 20) {
                    TextField("Artist", text: $viewModel.searchTerm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .background(Color.white)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .font(Font.system(size: 30, design: .default))
                    Button(action: {
                        self.viewModel.fetchTrackData()
                        self.isPresented = true
                    }, label: {
                        Text("Search Artist")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 65)
                            .font(.title)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                            .background(Color.white)
                    })
                    .fullScreenCover(isPresented: $isPresented) {
                        ResultsView(viewModel: viewModel, isPresented: $isPresented)
                    }
                    .cornerRadius(10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
