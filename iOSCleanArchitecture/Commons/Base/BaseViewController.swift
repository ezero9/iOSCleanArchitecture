//
//  BaseViewController.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol BaseViewInterface {
    var baseViewModel: BaseViewModelInterface! { get set }
    func showToast(message: String)
    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?)
    func hidePopup()
}

class BaseViewController: UIViewController {
    var baseViewModel: BaseViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseViewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LSLogTrace()
        baseViewModel.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LSLogTrace()
        baseViewModel.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LSLogTrace()
        baseViewModel.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LSLogTrace()
        baseViewModel.viewDidDisappear(animated)
    }
}

extension BaseViewController: BaseViewInterface {
    func showToast(message: String) {
        let toastLabel: UILabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height - 150, width: 300, height: 40))
        toastLabel.backgroundColor = UIColor.init(red: 50 / 255.0, green: 65 / 255.0, blue: 117 / 255.0, alpha: 1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center
        view.addSubview(toastLabel)
        
        toastLabel.text = message
        toastLabel.font = UIFont.boldSystemFont(ofSize: 15)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isBool) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
    }

    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?) {
        
    }
    
    func hidePopup() {
        
    }
}
