//
//  EyelidPaths.swift
//  NBFace
//
//  Created by Nate Horstmann on 7/28/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct EyelidPaths {
    
    static let UpperHappyOpen = EyelidPaths.makeUpperHappyOpen()
    static let UpperSadOpen = EyelidPaths.makeUpperSadOpen()
    static let UpperIdleOpen = EyelidPaths.makeUpperIdleOpen()
    
    static let LowerHappyOpen = EyelidPaths.makeLowerHappyOpen()
    static let LowerSadOpen = EyelidPaths.makeLowerSadOpen()
    static let LowerIdleOpen = EyelidPaths.makeLowerIdleOpen()
    
    static func makeUpperHappyOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 86.06, y: 193.6), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: -6.97, y: 307.77))
        path.addCurveToPoint(CGPoint(x: 507.15, y: 0), controlPoint1: CGPoint(x: 179.09, y: 79.43), controlPoint2: CGPoint(x: 258.44, y: 0))
        path.addCurveToPoint(CGPoint(x: 943.27, y: 181.95), controlPoint1: CGPoint(x: 608.65, y: 0), controlPoint2: CGPoint(x: 852.17, y: 24.2))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 1034.38, y: 339.71), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: 0))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.usesEvenOddFillRule = true
        
        return path
    }
    
    static func makeUpperSadOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 22.70, y: 407.74), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: -17.4, y: 465.77))
        path.addCurveToPoint(CGPoint(x: 520.3, y: 181.17), controlPoint1: CGPoint(x: 62.8, y: 349.71), controlPoint2: CGPoint(x: 240.66, y: 164.33))
        path.addCurveToPoint(CGPoint(x: 975.84, y: 383.77), controlPoint1: CGPoint(x: 799.93, y: 198.02), controlPoint2: CGPoint(x: 923.79, y: 344.67))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 1020.4200000000001, y: 417.25), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: 0))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.usesEvenOddFillRule =  true

        return path
    }
    
    static func makeUpperIdleOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 22.70, y: 407.74), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: -17.4, y: 465.77))
        path.addCurveToPoint(CGPoint(x: 500.52, y: 239.41), controlPoint1: CGPoint(x: 62.8, y: 349.71), controlPoint2: CGPoint(x: 251.81, y: 239.41))
        path.addCurveToPoint(CGPoint(x: 975.84, y: 383.77), controlPoint1: CGPoint(x: 749.23, y: 239.41), controlPoint2: CGPoint(x: 923.79, y: 344.67))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 1020.42, y: 417.25), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: 0))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.usesEvenOddFillRule =  true
        
        return path
    }
    
    static func makeLowerHappyOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 93.46, y: 852.37), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: 17.39, y: 769.27))
        path.addCurveToPoint(CGPoint(x: 528.55, y: 1001.98), controlPoint1: CGPoint(x: 169.53, y: 935.47), controlPoint2: CGPoint(x: 321.42, y: 1003.97))
        path.addCurveToPoint(CGPoint(x: 942.15, y: 816.27), controlPoint1: CGPoint(x: 735.69, y: 1000), controlPoint2: CGPoint(x: 906.35, y: 874.23))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 977.95, y: 758.3), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 1000))
        path.addLineToPoint(CGPoint(x: 0, y: 1000))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.usesEvenOddFillRule = true

        return path
    }
    
    static func makeLowerSadOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 93.46, y: 852.37), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: 17.39, y: 769.27))
        path.addCurveToPoint(CGPoint(x: 528.55, y: 1001.98), controlPoint1: CGPoint(x: 169.53, y: 935.47), controlPoint2: CGPoint(x: 321.42, y: 1003.97))
        path.addCurveToPoint(CGPoint(x: 942.15, y: 816.27), controlPoint1: CGPoint(x: 735.69, y: 1000), controlPoint2: CGPoint(x: 906.35, y: 874.23))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 977.95, y: 758.3), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 1000))
        path.addLineToPoint(CGPoint(x: 0, y: 1000))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.usesEvenOddFillRule = true
        
        return path
    }

    
    static func makeLowerIdleOpen() -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.addLineToPoint(CGPoint(x: -20, y: 500))
        path.addCurveToPoint(CGPoint(x: 93.46, y: 852.37), controlPoint1: CGPoint(x: -20, y: 500), controlPoint2: CGPoint(x: 17.39, y: 769.27))
        path.addCurveToPoint(CGPoint(x: 550.21, y: 975.53), controlPoint1: CGPoint(x: 169.53, y: 935.47), controlPoint2: CGPoint(x: 343.02, y: 993.84))
        path.addCurveToPoint(CGPoint(x: 942.15, y: 816.27), controlPoint1: CGPoint(x: 757.41, y: 957.23), controlPoint2: CGPoint(x: 906.35, y: 874.23))
        path.addCurveToPoint(CGPoint(x: 1020, y: 500), controlPoint1: CGPoint(x: 977.95, y: 758.3), controlPoint2: CGPoint(x: 1020, y: 500))
        path.addLineToPoint(CGPoint(x: 1000, y: 1000))
        path.addLineToPoint(CGPoint(x: 0, y: 1000))
        path.closePath()
        path.moveToPoint(CGPoint(x: 0, y: 1000))
        path.usesEvenOddFillRule = true
        
        return path
    }
}