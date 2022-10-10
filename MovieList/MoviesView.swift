//
//  ContentView.swift
//  MovieList
//
//  Created by Faysal on 10/10/22.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel = MoviesViewModel()
    @State private var searchText = "marvel"
    private let initialIndex = 1
    
    
    var body: some View {
        NavigationView {
            List(0..<self.viewModel.movieList.count, id: \.self) { i in
                
                if i == self.viewModel.movieList.count - 1 && viewModel.currentIndex <= viewModel.totalPage {
                    MovieView(movie: self.viewModel.movieList[i])
                        .onAppear {
                            self.viewModel.fetchMovies(query: searchText, page: viewModel.currentIndex + 1)
                        }
                } else {
                    MovieView(movie: self.viewModel.movieList[i])
                }
               
            }
            .searchable(text: $searchText, prompt: "Movie name")
            .onSubmit(of: .search) {
                self.viewModel.fetchMovies(query: searchText, page: initialIndex)
            }
            .navigationBarTitle("Movie List")
                .onAppear {
                    self.viewModel.fetchMovies(query: searchText, page: initialIndex)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}


