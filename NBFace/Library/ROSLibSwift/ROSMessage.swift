//
//  ROSMessage.swift
//  NBFace
//
//  Created by David Glivar on 3/22/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

protocol ROSMessage {
    static func Default() -> ROSMessage
    func asMsg() -> [String: AnyObject]
}
