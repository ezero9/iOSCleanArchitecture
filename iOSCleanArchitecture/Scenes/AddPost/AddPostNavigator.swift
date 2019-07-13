//
//  AddPostNavigator.swift
//  ExampleTODO
//
//  Created by LYJ on 17/01/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation
import UIKit

protocol AddPostNavigatorInterface: BaseNavigatorInterface {
}

class AddPostNavigator: BaseNavigator<AddPostViewController> {
}

extension AddPostNavigator: AddPostNavigatorInterface {
}
