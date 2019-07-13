//
//  Assembler.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

class Assembler {
    var assembles = [String: Any]()

    func register<T>(_ assemble: @escaping () -> T) {
        let key = String(describing: T.self)
        register(key: key, assemble)
    }

    func register<T>(key: String, _ assemble: @escaping () -> T) {
        guard assembles.keys.contains(key) == false else {
            fatalError("Already registered: \(key)")
        }
        assembles[key] = assemble
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        return resolve(key: key)
    }
    
    func resolve<T>(key: String) -> T {
        guard let maker = assembles[key] as? () -> T else {
            fatalError("not found \(key)")
        }
        
        return maker()
    }
    
    func contains(key: String) -> Bool {
        return assembles[key] != nil
    }
}
