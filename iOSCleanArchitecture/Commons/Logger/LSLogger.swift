//
//  LSLogger.swift
//  iOSCleanArchitecture
//
//  Created by yonghoon park on 2019. 6. 11..
//  Copyright © 2019년 yonghoon park All rights reserved.
//

import Foundation

enum Service: String {
    case Core = "[Core]"
    case Ambient = "[Ambient]"
    case Test = "[Test]"
    case IBeacon = "[IBeacon]"
    case NONE = ""
}

enum LogLevel: Int {
    case All = 0
    case Trace
    case Debug
    case Info
    case Warning
    case Error
    case Off
}

#if DEBUG
var LSLogLevel = LogLevel.All
#else
var LSLogLevel = LogLevel.Debug
#endif

func LSLogTrace(_ service: Service? = .NONE, _ logText: @autoclosure () -> String = "Enter", file: String = #file, function: String = #function, line: UInt = #line) {
    guard LSLogLevel.rawValue == LogLevel.All.rawValue || LSLogLevel.rawValue == LogLevel.Trace.rawValue else { return }
    Log.trace(wrap(logText(), service: service), file: file, function: function, line: line)
}

func LSLogDebug(_ service: Service?, _ logText: @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
    guard LSLogLevel.rawValue == LogLevel.All.rawValue || LSLogLevel.rawValue == LogLevel.Debug.rawValue else { return }
    Log.debug(wrap(logText(), service: service), file: file, function: function, line: line)
}

func LSLogInfo(_ service: Service?, _ logText: @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
    guard LSLogLevel.rawValue == LogLevel.All.rawValue || LSLogLevel.rawValue == LogLevel.Info.rawValue else { return }
    Log.info(wrap(logText(), service: service), file: file, function: function, line: line)
}

func LSLogWarn(_ service: Service?, _ logText: @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
    guard LSLogLevel.rawValue == LogLevel.All.rawValue || LSLogLevel.rawValue == LogLevel.Warning.rawValue else { return }
    Log.warning(wrap(logText(), service: service), file: file, function: function, line: line)
}

func LSLogError(_ service: Service?, _ logText: @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
    guard LSLogLevel.rawValue == LogLevel.All.rawValue || LSLogLevel.rawValue == LogLevel.Error.rawValue else { return }
    Log.error(wrap(logText(), service: service), file: file, function: function, line: line)
}

private func wrap(_ message: String, service: Service?) -> String {
    if let service = service {
        return "\(service.rawValue) \(message)"
    } else {
        return "\(message)"
    }
}
