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
    @Published var totalPage: Int = 0
    @Published var currentIndex = 1
    
    func fetchMovies(query: String, page: Int) {
        if page == initialIndex {
            self.movieList = []
        }
        self.currentIndex = page
        if let urlString = (url + query + "&page=\(page)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString.lowercased()) {
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                     do {
                       let movieList = try JSONDecoder().decode(Movielist.self, from: data)
                         
                         DispatchQueue.main.async {
                             self.totalPage = movieList.totalPages
                             let oldData = self.movieList
                             self.movieList = oldData + movieList.movies
                         }
                         
                     } catch let error {
                         print(error.localizedDescription)
                     }
                  } else {
                      print(error?.localizedDescription ?? "")
                  }
                }.resume()
                
            }
        }
    }
}
