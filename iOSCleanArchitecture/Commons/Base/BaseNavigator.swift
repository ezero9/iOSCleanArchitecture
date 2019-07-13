//
//  BaseNavigator.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import UIKit

protocol BaseNavigatorInterface {
    func pushViewController(from: UIViewController)
    func presentViewController(from: UIViewController)
    func popViewController()
    func dismiss()
    func returnToHome()
}

class BaseNavigator<T: BaseViewController>: BaseNavigatorInterface {
    var topViewController: UIViewController!

    func pushViewController(from: UIViewController) {
        mainThread {
            let vc: T = ApplicationContext.resolve()
            vc.baseViewModel.baseNavigator = self
            from.navigationController?.pushViewController(vc, animated: true)
            self.topViewController = vc
        }
    }
    
    func presentViewController(from: UIViewController) {
        mainThread {
            let vc: T = ApplicationContext.resolve()
            vc.baseViewModel.baseNavigator = self
            from.present(vc, animated: true)
            self.topViewController = vc
        }
    }
    
    func popViewController() {
        mainThread {
            self.topViewController.navigationController?.popViewController(animated: true)
        }
    }

    func dismiss() {
        mainThread {
            self.topViewController.dismiss(animated: true)
        }
    }

    func returnToHome() {

    }

    func initializeViewController<T>(storyboardName: String, identifier: String) -> T {
        guard let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("initialize failed: \(storyboardName) \(identifier)")
        }

        return vc
    }
}
