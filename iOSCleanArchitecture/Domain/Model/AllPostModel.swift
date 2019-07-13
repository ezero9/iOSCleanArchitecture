//
//  AllPostModel.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RxSwift

protocol AllPostModelInterface {
    func getAllPost() -> BehaviorSubject<[Post]>
}

class AllPostModel: AllPostModelInterface {
    private let allPostDAO: PostInterface!
    
    init(allPostDAO: PostInterface) {
        self.allPostDAO = allPostDAO
    }
    
    func getAllPost() -> BehaviorSubject<[Post]> {
        return allPostDAO.getAllPost()
    }
}
