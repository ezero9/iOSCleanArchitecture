//
//  DAO.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

enum DAOError: Error {
    case createFail(String)
    case readFail(String)
    case updateFail(String)
    case deleteFail(String)
}

protocol DAO {
    associatedtype KEY
    associatedtype VALUE
    
    func create(value: VALUE) throws
    func read(key: KEY) throws -> VALUE
    func update(value: VALUE) throws
    func delete(key: KEY) throws
}
