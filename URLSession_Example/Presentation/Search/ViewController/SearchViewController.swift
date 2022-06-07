//
//  SearchViewController.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import UIKit

import Kingfisher

final class SearchViewController: BaseViewController {

    let searchView = SearchView()
    let viewModel = SearchViewModel()

    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        bind()
    }
}

extension SearchViewController {
    private func bind() {
        viewModel.downloadedMovies.bind {[weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    private func assignDelegation() {
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.movieQuery.value = text
        viewModel.fetchData(query: text)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
       
        cell.updateCell(viewModel, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        
        let movieInfo = viewModel.movieInfo(at: indexPath.row)

        detailViewController.viewModel.movieInfo(at: movieInfo)
   
        self.present(detailViewController, animated: true)
    }
}
