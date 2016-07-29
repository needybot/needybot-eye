//
//  NBHandler.swift
//  NBFace
//
//  Created by David Glivar on 9/2/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation

class NBHandler: NSObject {
    
    var handle: (Any?...) -> ()
    var oneshot: Bool = false
    
    init(oneshot: Bool = false, handle: (Any?...) -> ()) {
        self.handle = handle
        self.oneshot = oneshot
        super.init()
    }
}