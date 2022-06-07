//
//  MovieModel.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/05/30.
//

import Foundation

struct MovieModel: Codable {
    let items: [Movies]
}

struct Movies: Codable {
    let image: String
    let title: String
    let director: String
    let actor: String
}
