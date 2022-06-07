//
//  SearchTableViewCell.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var directorLabel = UILabel()
    lazy var movieImage = UIImageView()
    lazy var actorLabel = UILabel()
    
    lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        [titleLabel, directorLabel, movieImage, actorLabel, verticalStackView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, directorLabel, actorLabel].forEach {
            verticalStackView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(100)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(movieImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.top)
            $0.leading.equalTo(verticalStackView.snp.leading)
        }
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(verticalStackView.snp.leading)
        }
        
        actorLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(verticalStackView.snp.leading)
        }
    }
    
    func updateCell(_ movieInfo: SearchViewModel, indexPath: IndexPath) {
        
        let value = movieInfo.downloadedMovies.value.movie[indexPath.row]
        
        titleLabel.text = value.title
        directorLabel.text = value.director
        actorLabel.text = value.actor
        
        if let url = URL(string: value.image) {
            self.movieImage.kf.setImage(with: url)
        }
    }
}
