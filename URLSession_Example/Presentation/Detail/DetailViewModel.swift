//
//  DetailViewModel.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import Foundation

class DetailViewModel {
    
    var downloadedMovies: Observable<MovieInfo> = Observable(MovieInfo(title: "", image: "", director: "", actor: ""))
    
    func movieInfo(at index: MovieInfo) {
        downloadedMovies.value = index
    }
}
