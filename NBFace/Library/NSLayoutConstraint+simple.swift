//
//  NSLayoutConstraint.swift
//  NBFace
//
//  Created by David Glivar on 8/3/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

public extension NSLayoutConstraint {
    
    static func simple(format: String, views: [String: AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: nil, views: views)
    }
}