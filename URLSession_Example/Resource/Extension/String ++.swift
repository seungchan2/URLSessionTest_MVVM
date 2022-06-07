//
//  String ++.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/06/01.
//

import Foundation

extension String {
    func removeString() -> String {
        return self.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}
