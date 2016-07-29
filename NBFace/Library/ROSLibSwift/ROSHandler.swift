//
//  ROSHandler.swift
//  ROSLibSwift
//
//  Created by David Glivar on 2/16/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

public class ROSHandler: NSObject {
    
    public typealias Handle = ([String: AnyObject]) -> ()
    
    public var handle: Handle
    
    public init(handle: ROSHandler.Handle) {
        self.handle = handle
    }
}