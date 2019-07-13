//
//  TestAllPostDAO.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RxSwift

class TestPostDAO: PostInterface {
    fileprivate let data = BehaviorSubject<[Post]>(value: [])
    private var dataStore = [Int: Post]()
    
    init() {
        //add default value
        for i in 1..<5 {
            dataStore[i] = Post(id: i, title: "TestData Title\(i)", contents: "contents\(i)")
        }
        data.onNext(Array(dataStore.values))
    }
    
    func getAllPost() -> BehaviorSubject<[Post]> {
        return data
    }
    
    func getPost(id: Int) throws -> Post {
        if let result = (try? data.value().first { $0.id == id }) as? Post {
            return result
        }

        throw NotFoundPost(message: "not found post: \(id)", code: 0)
    }
    
    func addPost(post: Post) {
        dataStore[post.id] = post
        data.onNext(Array(dataStore.values))
    }
}
