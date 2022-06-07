//
//  MovieTableViewCell.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/05/30.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    
    func updateCell(_ movieInfo: Movie) {
        titleLabel.text = movieInfo.title
        directorLabel.text = movieInfo.director
        actorLabel.text = movieInfo.actor
    }
}

