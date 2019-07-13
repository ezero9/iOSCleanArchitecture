//
//  DataBinding.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

protocol DataBinding {
    associatedtype Input
    associatedtype Output

    func bind(input: Input) -> Output
}
