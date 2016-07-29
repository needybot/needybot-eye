//
//  UIColor.swift
//  NBFace
//
//  Created by David Glivar on 8/3/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    public convenience init(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat) {
        self.init(red: (CGFloat(r) / 255.0), green: (CGFloat(g) / 255.0), blue: (CGFloat(b) / 255.0), alpha: (a / 1.0))
    }
}