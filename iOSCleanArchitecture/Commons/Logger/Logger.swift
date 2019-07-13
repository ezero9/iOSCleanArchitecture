//
//  Logger.swift
//  iOSCleanArchitecture
//
//  Created by yonghoon park on 2019. 6. 11..
//  Copyright © 2019년 yonghoon park All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

enum LogEvent: String {
    case trace = "TRACE"
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

class Log {
    class func trace( _ object: Any, file: String = #file, function: String = #function, line: UInt = #line) {
        DDLogVerbose("⚪️ \(LogEvent.trace.rawValue) \(sourceFileName(filePath: file))(\(line)): \(function) - \(object)")
    }

    class func debug( _ object: Any, file: String = #file, function: String = #function, line: UInt = #line) {
        DDLogDebug("☑️ \(LogEvent.debug.rawValue) \(sourceFileName(filePath: file))(\(line)): \(function) - \(object)")
    }

    class func info( _ object: Any, file: String = #file, function: String = #function, line: UInt = #line) {
        DDLogInfo("🔵 \(LogEvent.info.rawValue) \(sourceFileName(filePath: file))(\(line)): \(function) - \(object)")
    }

    class func warning( _ object: Any, file: String = #file, function: String = #function, line: UInt = #line) {
        DDLogWarn("🔶 \(LogEvent.warning.rawValue) \(sourceFileName(filePath: file))(\(line)): \(function) - \(object)")
    }

    class func error( _ object: Any, file: String = #file, function: String = #function, line: UInt = #line) {
        DDLogError("🔴 \(LogEvent.error.rawValue) \(sourceFileName(filePath: file))(\(line)): \(function) - \(object)")
    }

    private class func sourceFileName(filePath: String) -> String {
        guard let fullFileName = filePath.components(separatedBy: "/").last, let fileName = fullFileName.components(separatedBy: ".").first else { return "" }
        return fileName
    }

}

// MARK: CocoaLumberjack - DDLog
extension Log {
    class var fullLogData: NSMutableData {
        let fileLoger = DDFileLogger()
        let sortedLogFileInfos = fileLoger.logFileManager.sortedLogFileInfos.reversed()

        let logData = NSMutableData()
        DDLog.flushLog()

        for logFileInfo in sortedLogFileInfos {
            if let fileData: NSData = NSData(contentsOfFile: logFileInfo.filePath) {
                logData.append(fileData as Data)
            }
        }
        return logData
    }

    class func setupDDLog() {
        removeLogStack()

        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 10
        fileLogger.logFileManager.logFilesDiskQuota = (UInt64(10 * 1024 * 1024))  // 10 MB
        fileLogger.maximumFileSize = 1024 * 1024  // 1 MB
        DDLog.add(fileLogger)
    }

    class func saveLogFile() {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/LifeStyle.txt")

        fullLogData.write(toFile: filePath, atomically: true)
    }

    class func removeLogStack() {
        let fileLogger = DDFileLogger()
        fileLogger.rollLogFile(withCompletion: {
            for filename: String in fileLogger.logFileManager.sortedLogFilePaths {
                do {
                    try FileManager.default.removeItem(atPath: filename)
                } catch {
                    LSLogError(.NONE, error.localizedDescription)
                }
            }
        })
    }
}
