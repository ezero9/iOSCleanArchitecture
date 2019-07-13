//
//  DispatchQueue.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 28/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

func mainThread(_ execute: @escaping () -> Void) {
    DispatchQueue.main.async(execute: {
        execute()
    })
}

func mainThreadAsyncAfter(_ seconds: Double, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        execute()
    }
}

func mainThreadAsyncAfter(_ seconds: Double, execute: DispatchWorkItem) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}

func backgroundThread(_ execute: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async(execute: {
        execute()
    })
}

func backgroundThreadAsyncAfter(_ seconds: Double, execute: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + seconds) {
        execute()
    }
}

func backgroundThreadAsyncAfter(_ seconds: Double, execute: DispatchWorkItem) {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + seconds, execute: execute)
}
