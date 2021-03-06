//
//  NSTimer+Closure.swift
//  NBFace
//
//  Created by David Glivar on 10/1/15.
//  Copyright © 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation

// From https://gist.github.com/natecook1000/b0285b518576b22c4dc8

extension NSTimer {
    /**
        Creates and schedules a one-time `NSTimer` instance.
        - Parameter delay: The delay before execution.
        - Parameter handler: A closure to execute after `delay`.
        - Returns: The newly-created `NSTimer` instance.
    */
    class func schedule(delay delay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
    
    /**
        Creates and schedules a repeating `NSTimer` instance.
        - Parameter repeatInterval: The interval between each execution of `handler`. 
            Note that individual calls may be delayed; subsequent calls to `handler` 
            will be based on the time the `NSTimer` was created.
        - Parameter handler: A closure to execute after `delay`.
        - Returns: The newly-created `NSTimer` instance.
    */
    class func schedule(repeatInterval interval: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
}