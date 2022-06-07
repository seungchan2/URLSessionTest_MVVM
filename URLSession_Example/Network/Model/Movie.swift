//
//  Movie.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/05/30.
//

import Foundation

struct Movie {
    var movie: [MovieInfo]
}

struct MovieInfo {
    var title: String
    let image: String
    let director: String
    let actor: String
}
