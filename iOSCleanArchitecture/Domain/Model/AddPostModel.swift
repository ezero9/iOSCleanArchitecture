//
//  AddPostModel.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RxSwift

protocol AddPostModelInterface {
    func addPost(post: Post)
}

class AddPostModel: AddPostModelInterface {
    private let postDao: PostInterface!
    
    init(postDao: PostInterface) {
        self.postDao = postDao
    }
    
    func addPost(post: Post) {
        return postDao.addPost(post:post)
    }
}
