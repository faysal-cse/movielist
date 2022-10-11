//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Faysal on 10/10/22.
//


import Combine
import SwiftUI

class MoviesViewModel: ObservableObject {
    private let initialIndex = 1
    private let url = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query="
    private var task: AnyCancellable?
            
    @Published var movieList: [Movie] = [Movie]()
    @Published var movieListObj: Movielist = Movielist(page: 0, movies: [], totalPages: 0, totalResults: 0)
    
    @Published var totalPage: Int = 0
    @Published var currentIndex = 1
    
    func fetchMovies(query: String, page: Int) {
        if page == initialIndex {
            self.movieList = []
        }
        self.currentIndex = page
        if let urlString = (url + query + "&page=\(page)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString.lowercased()) {
                
                task = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data}
                    .decode(type: Movielist.self, decoder: JSONDecoder())
                    .replaceError(with: Movielist(page: 0, movies: [], totalPages: 0, totalResults: 0))
                    .eraseToAnyPublisher()
                    .receive(on: RunLoop.main)
                    .handleEvents(receiveOutput: { response in
                        self.movieList = self.movieList + response.movies
                        self.totalPage = response.totalPages
                    })
                    .assign(to: \MoviesViewModel.movieListObj, on: self)
                
            }
        }
    }
}
