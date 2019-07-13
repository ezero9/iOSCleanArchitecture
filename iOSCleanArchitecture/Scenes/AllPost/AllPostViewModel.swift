//
//  AllPostViewModel.swift
//  ExampleTODO
//
//  Created by LYJ on 17/01/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AllPostViewModel: BaseViewModel {
    private let allPostModel: AllPostModelInterface
    private var navigator: AllPostNavigator!
    override var baseNavigator: BaseNavigatorInterface! {
        didSet {
            navigator = baseNavigator as? AllPostNavigator
        }
    }
    
    init(allPostModel: AllPostModelInterface) {
        self.allPostModel = allPostModel
    }
}

extension AllPostViewModel: DataBinding {
    func bind(input: AllPostViewModel.Input) -> AllPostViewModel.Output {
        let addPost = input.addPostTrigger.do(onNext: { self.navigator?.toAddPost() })
        let output = Output(allPost: allPostModel.getAllPost(),
                            addPost: addPost)
        
        return output
    }
    
    struct Input {
        let addPostTrigger: Driver<Void>
    }

    struct Output{
        let allPost: BehaviorSubject<[Post]>
        let addPost: Driver<Void>
    }
}

