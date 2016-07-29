//
//  CGRect+utils.swift
//  NBFace
//
//  Created by David Glivar on 3/26/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    
    func centerInRect(rect: CGRect, xOffset: CGFloat = 0, yOffset: CGFloat = 0) -> CGRect {
        let x = (rect.width * 0.5 - size.width * 0.5) + xOffset
        let y = (rect.height * 0.5 - size.height * 0.5) + yOffset
        return CGRectMake(x, y, size.width, size.height)
    }
    
    mutating func centerInRectMut(rect: CGRect, xOffset: CGFloat = 0, yOffset: CGFloat = 0) -> CGRect {
        let centered = self.centerInRect(rect, xOffset: xOffset, yOffset: yOffset)
        origin = centered.origin
        size = centered.size
        return self
    }
    
    func getCenter() -> CGPoint {
        let x = self.width * 0.5 + self.origin.x
        let y = self.height * 0.5 + self.origin.y
        return CGPoint(x: x, y: y)
    }
}