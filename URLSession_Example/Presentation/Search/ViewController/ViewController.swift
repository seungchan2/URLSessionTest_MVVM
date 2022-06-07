//
//  ViewController.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/05/30.
//

import UIKit

import Kingfisher

final class ViewController: UIViewController {
    
    var downloadedMovies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var query: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerXib()
        fetchData()
    }
}

extension ViewController {
    private func assignDelegation() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func fetchData() {
        MovieDataManager.shared.fetchMovie(query: query) {[weak self] (movies) in
            if let movies = movies {
                
                self?.downloadedMovies = movies
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        downloadedMovies.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        MovieDataManager.shared.fetchMovie(query: text) { [weak self](movies) in
            if let movies = movies {
                
                movies.forEach {
                    let director = $0.director.removeString()
                    let title = $0.title.removeString()
                    let data = Movie(title: title, image: $0.image, director: director, actor: $0.actor)
                    self?.downloadedMovies += [data]
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.updateCell(downloadedMovies[indexPath.row])
        
        DispatchQueue.global().async {
            if let url = URL(string: self.downloadedMovies[indexPath.row].image) {
                DispatchQueue.main.async {
                    cell.movieImageView.kf.setImage(with: url)
                }
            }
        }
        return cell
    }
}
