//
//  CommonRealmDAO.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import UIKit

protocol RealmEntity {
    associatedtype ENTITY
    var query: String { get set }
    func mapping(entity: ENTITY)
    func getEntity() -> ENTITY
}

protocol RealmEntityMapper {
    associatedtype REALM_ENTITY
    func getRealmEntity() -> REALM_ENTITY
}

class CommonRealmDAO<VALUE: RealmEntityMapper>: DAO where VALUE.REALM_ENTITY: Object, VALUE.REALM_ENTITY: RealmEntity {
    typealias KEY = String
    var realm: Realm!

    init() {
        guard let m = try? Realm(configuration: getRealmConfig()) else {
            fatalError("initialize failed.")
        }
        realm = m
    }

    func getRealmConfig() -> Realm.Configuration {
        return Realm.Configuration()
    }

    func create(value: VALUE) throws {
        do {
            try realm.write {
                realm.add(value.getRealmEntity())
            }
        } catch let error as NSError {
            throw DAOError.createFail(error.description)
        }
    }
    
    func read(key: KEY) throws -> VALUE {
        let value: VALUE.REALM_ENTITY = try read(key: key)
        if let result = value.getEntity() as? VALUE {
            return result
        }

        throw DAOError.readFail("not found \(key)/ getEntity failed.")
    }
    
    private func read(key: KEY) throws -> VALUE.REALM_ENTITY {
        if let result = realm.object(ofType: VALUE.REALM_ENTITY.self, forPrimaryKey: key) {
            return result
        }
        
        throw DAOError.readFail("not found \(key)")
    }
    
    func update(value: VALUE) throws {
        do {
            try realm.write {
                realm.add(value.getRealmEntity(), update: true)
            }
        } catch let error as NSError {
            throw DAOError.updateFail(error.description)
        }
    }
    
    func delete(key: KEY) throws {
        do {
            try realm.write {
                let value: VALUE.REALM_ENTITY = try read(key: key)
                realm.delete(value)
            }
        } catch let error as NSError {
            throw DAOError.deleteFail(error.description)
        }
    }
}
