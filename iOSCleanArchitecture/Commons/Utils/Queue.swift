//
//  Queue.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 21/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

protocol Queue {
    associatedtype T
    mutating func push(_ element: T)
    mutating func front() -> T?
    mutating func pop() -> T?
    mutating func popAll() -> [T]
    mutating func goBack(_ element: T)
    func size() -> Int
    func isEmpty() -> Bool
}

struct ArrayQueue<T: Equatable>: Queue {
    private var elements = Array<T>()
    
    mutating func push(_ element: T) {
        elements.append(element)
    }

    mutating func front() -> T? {
        return elements.first
    }

    @discardableResult
    mutating func pop() -> T? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
    
    @discardableResult
    mutating func popAll() -> [T] {
        let result = elements
        elements.removeAll()
        return result
    }
    
    mutating func goBack(_ element: T) {
        if let index = elements.firstIndex(where: { return $0 == element }) {
            elements.remove(at: index)
        }
        push(element)
    }
    
    func size() -> Int {
        return elements.count
    }
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
}

extension ArrayQueue: Sequence, IteratorProtocol {
    mutating func next() -> T? { return pop() }
}

struct ThreadSafeArrayQueue<T: Equatable>: Queue {
    private let lock = NSLock()
    private var queue = ArrayQueue<T>()

    mutating func push(_ element: T) {
        lock.lock()
        defer { lock.unlock() }
        queue.push(element)
    }

    mutating func front() -> T? {
        return queue.front()
    }

    @discardableResult
    mutating func pop() -> T? {
        lock.lock()
        defer { lock.unlock() }
        return queue.pop()
    }
    
    mutating func popAll() -> [T] {
        lock.lock()
        defer { lock.unlock() }
        return queue.popAll()
    }
    
    mutating func goBack(_ element: T) {
        lock.lock()
        defer { lock.unlock() }
        queue.goBack(element)
    }
    
    func size() -> Int {
        lock.lock()
        defer { lock.unlock() }
        return queue.size()
    }
    
    func isEmpty() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return queue.isEmpty()
    }
}

extension ThreadSafeArrayQueue: Sequence, IteratorProtocol {
    mutating func next() -> T? { return pop() }
}
