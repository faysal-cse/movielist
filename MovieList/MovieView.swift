//
//  MovieView.swift
//  MovieList
//
//  Created by Faysal on 10/10/22.
//

import SwiftUI

struct MovieView: View {
    private let movie: Movie
    private let imagePth = "https://image.tmdb.org/t/p/original"
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: imagePth + (movie.posterPath ?? "")),
              content: { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fit)
            }, placeholder: {
              Color.gray
            })
              .frame(width: 80, height: 100)
               
            VStack(alignment: .leading, spacing: 15) {
                Text(movie.title)
                    .font(.system(size: 18))
                    .foregroundColor(Color.blue)
                Text(movie.overview)
                    .font(.system(size: 14))
            }
        }
    }
}
