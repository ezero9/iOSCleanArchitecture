//
//  WeakRef.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 21/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

struct WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}
