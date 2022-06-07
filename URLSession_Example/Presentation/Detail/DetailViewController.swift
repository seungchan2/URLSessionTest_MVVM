//
//  DetailViewController.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    let viewModel = DetailViewModel()

    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.downloadedMovies.bind { [weak self] _ in
            guard let self = self else { return }
            self.detailView.titleLabel.text = self.viewModel.downloadedMovies.value.title
            self.detailView.directorLabel.text = self.viewModel.downloadedMovies.value.director
        }
    }
}
