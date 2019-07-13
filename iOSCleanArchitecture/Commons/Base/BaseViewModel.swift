//
//  BaseViewModel.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

protocol BaseViewModelInterface {
    var baseNavigator: BaseNavigatorInterface! { get set }
    var baseViewController: BaseViewInterface! { get set }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
    func popViewController()
}

class BaseViewModel: BaseViewModelInterface {
    var baseNavigator: BaseNavigatorInterface!
    var baseViewController: BaseViewInterface!
    let eventService = ApplicationContext.resolve() as EventService

    func viewDidLoad() {
        eventService.addEventListener(self)
    }
    
    func viewWillAppear(_ animated: Bool) {

    }
    
    func viewDidAppear(_ animated: Bool) {
        
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func viewDidDisappear(_ animated: Bool) {

    }

    func popViewController() {
        baseNavigator.popViewController()
    }
}

extension BaseViewModel: EventServiceListener {
    func onEvent(event: EventService.EventType) {
        switch event {
        case .netwrokConnect:
            baseViewController.showToast(message: "networkConnect!")
        case .netwrokDisConnect:
            baseViewController.showToast(message: "networkDisConnect!")
        }
    }
}
