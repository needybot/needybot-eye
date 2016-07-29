//
//  NBManager.swift
//  NBFace
//
//  Created by David Glivar on 2/8/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

protocol NBManager: class {
    var handlers: [NBHandler] { get set }
    func addHandler(handler: NBHandler) -> Bool
    func removeHandler(handler: NBHandler) -> Bool
    func runStack(args: Any?...)
}

extension NBManager {
    
    func addHandler(handler: NBHandler) -> Bool {
        guard let _ = handlers.indexOf(handler) else {
            handlers.append(handler)
            return true
        }
        return false
    }
    
    func removeHandler(handler: NBHandler) -> Bool {
        guard let idx = handlers.indexOf(handler) else {
            return false
        }
        handlers.removeAtIndex(idx)
        return true
    }
    
    func removeAllHandlers() {
        handlers = []
    }
    
    func runStack(args: Any?...) {
        var toremove = [NBHandler]()
        for handler in handlers {
            handler.handle(args)
            if handler.oneshot {
                toremove.append(handler)
            }
        }
        for handler in toremove {
            removeHandler(handler)
        }
    }
}