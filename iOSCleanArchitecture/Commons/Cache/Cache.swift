//
//  Cache.swift
//  iOSCleanArchitecture
//
//  Created by Lee YoungJu on 2019. 7. 13..
//  Copyright © 2019년 Lee YoungJu. All rights reserved.
//

import Foundation

protocol Cache {
    associatedtype CachedDataType
    func add(key: String, value: CachedDataType)
    func get(key: String) throws -> CachedDataType
    func remove(key: String)
    func getOrAdd(key: String, execute: () throws -> CachedDataType?) throws -> CachedDataType
    func getOrAddAsync(key: String, result: @escaping (CachedDataType) -> Void, execute: (@escaping (CachedDataType) -> Void) -> Void)
    func getAndRenewOrAddAsync(key: String, result: @escaping (CachedDataType) -> Void, renew: @escaping (@escaping (CachedDataType) -> Void) -> Void, execute: (@escaping (CachedDataType) -> Void) -> Void)
}

class MemoryCache<T>: Cache {
    enum CacheError: Error {
        case notFound(message: String)
    }
    private var cachedDataMap = [String: T]()
    private var cachePriority = ArrayQueue<String>()
    private(set) var limitMaxSize = 100

    init(limitMaxSize: Int) {
        self.limitMaxSize = limitMaxSize
    }

    func add(key: String, value: CachedDataType) {
        cachedDataMap[key] = value
        cachePriority.push(key)
        removeOldData()
    }

    func get(key: String) throws -> T {
        guard let cachedData = cachedDataMap[key] else {
            throw CacheError.notFound(message: "Not Found: \(key)")
        }

        cachePriority.goBack(key)
        return cachedData
    }

    func remove(key: String) {
        cachePriority.pop()
        cachedDataMap.removeValue(forKey: key)
    }

    func getOrAdd(key: String, execute: () throws -> T?) throws -> T {
        do {
            let cachedData = try get(key: key)
            return cachedData
        } catch {
            guard let cachedData = try execute() else { throw CacheError.notFound(message: "execute return is nil.") }
            add(key: key, value: cachedData)
            return cachedData
        }
    }
    
    func getOrAddAsync(key: String, result: @escaping (T) -> Void, execute: (@escaping (T) -> Void) -> Void) {
        do {
            result(try get(key: key))
        } catch {
            execute({ [weak self] value in
                guard let self = self else { return }
                self.add(key: key, value: value)
                result(value)
            })
        }
    }

    func getAndRenewOrAddAsync(key: String, result: @escaping (T) -> Void, renew: @escaping (@escaping (T) -> Void) -> Void, execute: (@escaping (T) -> Void) -> Void) {
        do {
            result(try get(key: key))
            renew({ [weak self] value in
                guard let self = self else { return }
                self.remove(key: key)
                self.add(key: key, value: value)
            })
        } catch {
            execute({ [weak self] value in
                guard let self = self else { return }
                self.add(key: key, value: value)
                result(value)
            })
        }
    }

    private func removeOldData() {
        while(isLimit()) {
            guard let key = cachePriority.front() else { return }
            remove(key: key)
        }
    }

    func isLimit() -> Bool {
        return cachedDataMap.count > limitMaxSize
    }

    typealias CachedDataType = T
}

class ImageMemoryCache: MemoryCache<Data> {
    private(set) var currentSize = 0
    
    override func add(key: String, value: Data) {
        super.add(key: key, value: value)
        currentSize += value.count
    }
    
    override func remove(key: String) {
        let value = try? get(key: key)
        currentSize -= value?.count ?? 0
        super.remove(key: key)
    }
    
    override func isLimit() -> Bool {
        return currentSize > limitMaxSize
    }
}

class RealmCache {
    
}
