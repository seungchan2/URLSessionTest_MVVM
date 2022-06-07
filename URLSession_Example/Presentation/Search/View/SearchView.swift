//
//  SearchView.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import UIKit

import SnapKit
import Then

final class SearchView: UIView {
    
    lazy var tableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        $0.separatorInset.left = 15
        $0.separatorInset.right = 15
        $0.rowHeight = 120
    }
    
    lazy var searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        [searchBar, tableView].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
        
    }
}
