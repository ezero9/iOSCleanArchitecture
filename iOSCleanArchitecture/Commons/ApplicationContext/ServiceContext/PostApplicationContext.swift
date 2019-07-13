//
//  ProdApplicationContext.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

class PostApplicationContext: AbstractApplicationContext {
    override func configure() {
        registerSingleton({ return EventService() })
        registerSingleton(key: "realmPostDAO", { return RealmPostDAO() })
        
        register({ return AllPostModel(allPostDAO: self.resolve(key: "realmPostDAO")) as AllPostModelInterface })
        register({ return AllPostViewModel(allPostModel: self.resolve()) })
        register({ () -> AllPostViewController in
            let result: ViewInfo<AllPostViewController, AllPostViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "AllPost", identifier: "AllPostViewController")
            return result.view
        })
        
        register({ return AddPostModel(postDao: self.resolve(key: "realmPostDAO")) as AddPostModelInterface })
        register({ return AddPostViewModel(addPostModel: self.resolve()) })
        register({ () -> AddPostViewController in
            let result: ViewInfo<AddPostViewController, AddPostViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "AddPost", identifier: "AddPostViewController")
            return result.view
        })
    }
}
