//
//  SearchViewModel.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import Foundation

class SearchViewModel {
    
    let searchView = SearchView()
    var downloadedMovies: Observable<Movie> = Observable(Movie(movie: []))
    var movieQuery: Observable<String> = Observable("")
    var title: Observable<String> = Observable("")
    
    func fetchData(query: String) {
        MovieDataManager.shared.fetchMovie(query: movieQuery.value) {[weak self] (movies) in
            guard let self = self else { return }
            if let movies = movies {

                movies.forEach {
                    let actor = $0.actor.removeString()
                    let director = $0.director.removeString()
                    let title = $0.title.removeString()
                    let data = MovieInfo(title: title , image: $0.image, director: director, actor: actor)
                    self.downloadedMovies.value.movie += [data]
                }
            }
        }
    }
    
    var numOfRowInSection: Int {
        return downloadedMovies.value.movie.count
    }
    
    func practiceCell(at indexPath: IndexPath) {
        self.title.value = self.downloadedMovies.value.movie[indexPath.row].title
    }
    
    func movieInfo(at index: Int) -> MovieInfo {
        return downloadedMovies.value.movie[index]
    }
    
}
