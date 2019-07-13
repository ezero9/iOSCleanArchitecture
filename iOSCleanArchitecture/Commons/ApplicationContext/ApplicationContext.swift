//
//  ApplicationContext.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

class ApplicationContext: AbstractApplicationContext {
    private static var soleInstance: AbstractApplicationContext?
    
    static private func getInstance() -> AbstractApplicationContext {
        guard let soleInstance = self.soleInstance else {
            fatalError("ApplicationContext is not initialized")
        }
        
        return soleInstance
    }
    
    static func initialize(_ source: ApplicationContextType = .prod) {
        soleInstance = ApplicationContext()

        switch source {
        case .prod:
            getInstance().registerSingleton({ PostApplicationContext() })
            //getInstance().registerSingleton({ ServiceName1Context() })
        case .test:
            getInstance().registerSingleton({ TestPostApplicationContext() })
            //getInstance().registerSingleton({ ServiceName1TestContext() })
        }
    }
    
    static func destroy() {
        soleInstance = nil
    }
    
    static func getObject<T>(key: String) -> T {
        for (_, element) in getInstance().singletonMap.enumerated() {
            if let context = element.value as? AbstractApplicationContext, context.contains(key: key) {
                return context.resolve()
            }
        }
        
        fatalError("not found \(key)")
    }
    
    static func resolve<T>() -> T {
        return getObject(key: String(describing: T.self))
    }
}

enum ApplicationContextType {
    case prod
    case test
}
