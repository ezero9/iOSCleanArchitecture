//
//  AllPostNavigator.swift
//  ExampleTODO
//
//  Created by YoungJu Lee on 16/01/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation
import UIKit

protocol AllPostNavigatorInterface: BaseNavigatorInterface {
    func toAddPost()
    func toEditPost()
    func toDetailPost()
}

class AllPostNavigator: BaseNavigator<AllPostViewController> {
}

extension AllPostNavigator: AllPostNavigatorInterface {
    func toAddPost() {
        AddPostNavigator().presentViewController(from: topViewController)
    }

    func toEditPost() {
        //TODO EditPostNavigator().pushViewcontroller(from: topViewController)
    }

    func toDetailPost() {
        //TODO DetailPostNavigator().pushViewcontroller(from: topViewController)
    }
}
