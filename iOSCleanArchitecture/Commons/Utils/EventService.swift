//
//  EventService.swift
//  iOSCleanArchitecture
//
//  Created by LYJ on 30/05/2019.
//  Copyright © 2019 이영주. All rights reserved.
//

import Foundation

class EventService {
    enum EventType {
        case netwrokConnect
        case netwrokDisConnect
    }

    private var listeners = [WeakRef<AnyObject>]()

    func addEventListener(_ listener: EventServiceListener) {
        listeners.append(WeakRef(value: listener as AnyObject))
        
    }

    func removeListener(_ listener: EventServiceListener) {
        
    }
    
    private func removeListener(_ weakRefListener: WeakRef<AnyObject>) {

    }

    func notifyEvent(event: EventType) {
        listeners.forEach { weakRefListener in
            mainThread {
                guard let listener = weakRefListener.value as? EventServiceListener else {
                    self.removeListener(weakRefListener)
                    return
                }
                listener.onEvent(event: event)
            }
        }
    }
}

protocol EventServiceListener: AnyObject {
    func onEvent(event: EventService.EventType)
}
