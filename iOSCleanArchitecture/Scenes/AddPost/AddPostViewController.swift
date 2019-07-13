//
//  AddPostViewController.swift
//  ExampleTODO
//
//  Created by LYJ on 17/01/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddPostViewController: BaseViewController {
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextView!
    
    override var baseViewModel: BaseViewModelInterface! {
        didSet {
            addPostViewModel = baseViewModel as? AddPostViewModel
        }
    }
    
    private var addPostViewModel: AddPostViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawContents()
        
        let ouput = addPostViewModel.bind(input: AddPostViewModel.Input(title: titleTextField.rx.text.orEmpty.asDriver(),
                                                                      contents: contentsTextField.rx.text.orEmpty.asDriver(),
                                                                      saveBtn: saveButton.rx.tap.asDriver(),
                                                                      cancelBtn: cancelButton.rx.tap.asDriver()))
        
        ouput.saveBtnEnable.drive(saveButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    private func drawContents() {
        self.contentsTextField.layer.borderColor = UIColor.gray.cgColor
        self.contentsTextField.layer.borderWidth = 2.3
        self.contentsTextField.layer.cornerRadius = 15
    }
}
