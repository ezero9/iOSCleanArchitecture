//
//  Zip3.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 21/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

struct Zip3Sequence<E1, E2, E3>: Sequence, IteratorProtocol {
    private let _next: () -> (E1, E2, E3)?
    
    init<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) where S1.Element == E1, S2.Element == E2, S3.Element == E3 {
        var it1 = s1.makeIterator()
        var it2 = s2.makeIterator()
        var it3 = s3.makeIterator()
        _next = {
            guard let e1 = it1.next(), let e2 = it2.next(), let e3 = it3.next() else { return nil }
            return (e1, e2, e3)
        }
    }
    
    mutating func next() -> (E1, E2, E3)? {
        return _next()
    }
}

func zip3<S1: Sequence, S2: Sequence, S3: Sequence>(_ s1: S1, _ s2: S2, _ s3: S3) -> Zip3Sequence<S1.Element, S2.Element, S3.Element> {
    return Zip3Sequence(s1, s2, s3)
}
