//
//  ReamPostDAO.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RealmPostDAO: PostInterface {
    fileprivate let data = BehaviorSubject<[Post]>(value: [])
    private var dataStore = CommonRealmDAO<Post>()
    init() {
        
    }
    
    func getAllPost() -> BehaviorSubject<[Post]> {
        return data
    }
    
    func getPost(id: Int) throws -> Post {
        throw NotFoundPost(message: "not found post: \(id)", code: 0)
    }
    
    func addPost(post: Post) {

    }
}

class PostRealmEntity: Object, RealmEntity {
    typealias ENTITY = Post
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var contents: String = ""
    
    var query: String = ""
    
    func mapping(entity: ENTITY) {
        id = entity.id
        title = entity.title
        contents = entity.contents
    }
    
    func getEntity() -> ENTITY {
        return Post(id: id, title: title, contents: contents)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Post: RealmEntityMapper {
    typealias REALM_ENTITY = PostRealmEntity
    func getRealmEntity() -> REALM_ENTITY {
        let mapper = PostRealmEntity()
        mapper.mapping(entity: self)
        return mapper
    }
}
