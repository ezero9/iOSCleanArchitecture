//
//  Extensions.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 21/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
