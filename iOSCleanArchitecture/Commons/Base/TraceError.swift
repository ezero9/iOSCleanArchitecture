//
//  TraceError.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

class TraceError: Error {
    let message: String
    let code: Int
    let userInfo: Any?
    let prevError: TraceError?
    private let errorPlace: String
    
    init(message: String, code: Int, userInfo: Any? = nil, prevError: TraceError? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
        self.message = message
        self.code = code
        self.userInfo = userInfo
        self.prevError = prevError
        self.errorPlace = "\(file) \(line): \(function) -"
    }
    
    func getStackTrace() -> String {
        return getStackTrace(depth: 1)
    }
    
    private func getStackTrace(depth: Int) -> String {
        let prefix = depth == 1 ? "🔶[ERROR TRACE]🔶\n\t 🔶 " : ""
        return "\(prefix)\(errorPlace) \(String(describing: self)): \(message) \(prevError != nil ? "\n\t 🔶" : "") \(prevError?.getStackTrace(depth: depth + 1) ?? "")"
    }
    
    func getSourceError() -> TraceError {
        return prevError?.getSourceError() ?? self
    }
}
