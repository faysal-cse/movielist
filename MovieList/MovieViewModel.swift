//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Faysal on 10/10/22.
//


import Combine
import SwiftUI

class MoviesViewModel: ObservableObject {
    private let url = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query="
    private var task: AnyCancellable?
            
    @Published var movieList: Movielist = Movielist(page: 0, movies: [], totalPages: 0, totalResults: 0)
    
    func fetchMovies(query: String) {
        
        if let urlString = (url + query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString.lowercased()) {
                task = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data}
                    .decode(type: Movielist.self, decoder: JSONDecoder())
                    .replaceError(with: Movielist(page: 0, movies: [], totalPages: 0, totalResults: 0))
                    .eraseToAnyPublisher()
                    .receive(on: RunLoop.main)
                    .assign(to: \MoviesViewModel.movieList, on: self)
            }
        }
    }
}
