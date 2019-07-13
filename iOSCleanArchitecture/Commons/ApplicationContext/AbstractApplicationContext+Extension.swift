//
//  AbstractApplicationContext+Extension.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import UIKit

extension AbstractApplicationContext {
    func initializeViewControllerAndViewModel<T1: BaseViewInterface, T2: BaseViewModelInterface>(storyboardName: String, identifier: String) -> ViewInfo<T1, T2> {
        var vc: T1 = initializeViewController(storyboardName: storyboardName, identifier: identifier)
        var vm: T2 = self.resolve()
        vm.baseViewController = vc
        vc.baseViewModel = vm
        
        return ViewInfo(view: vc, viewModel: vm)
    }
    
    func initializeViewController<T>(storyboardName: String, identifier: String) -> T {
        guard let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("initialize failed: \(storyboardName) \(identifier)")
        }
        
        return vc
    }
}

class ViewInfo<T1, T2> {
    let view: T1
    let viewModel: T2
    init(view: T1, viewModel: T2) {
        self.view = view
        self.viewModel = viewModel
    }
}
