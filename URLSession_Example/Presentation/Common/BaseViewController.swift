//
//  BaseViewController.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
}
