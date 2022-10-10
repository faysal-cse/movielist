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

    var body: some View {
        NavigationView {
            List(viewModel.movieList.movies, id: \.self) {
                MovieView(movie: $0)
                    .onAppear {
                        if self.viewModel.movieList.movies.last == $0 {
                            
                        }
                    }
            }
            .searchable(text: $searchText, prompt: "Movie name")
            .onSubmit(of: .search) {
                
                self.viewModel.fetchMovies(query: searchText)

            }
            .navigationBarTitle("Movies")
                .onAppear {
                    self.viewModel.fetchMovies(query: searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}


