//
//  AllPostDAOInterface.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RxSwift

protocol PostInterface {
    func getAllPost() -> BehaviorSubject<[Post]>
    func getPost(id: Int) throws -> Post
    func addPost(post: Post)
}

class NotFoundPost: TraceError {
    
}
