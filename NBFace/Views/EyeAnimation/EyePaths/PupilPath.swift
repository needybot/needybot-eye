//
//  PupilPath.swift
//  NBEyeAnimation
//
//  Created by Nate Horstmann on 7/11/16.
//  Copyright © 2016 Nate Horstmann. All rights reserved.
//

import Foundation
import UIKit

class PupilPath: UIBezierPath {
    override init() {
        super.init()
        
        moveToPoint(CGPoint(x: 1.05, y: 426.45))
        addCurveToPoint(CGPoint(x: 481.75, y: 999.09), controlPoint1: CGPoint(x: -16.03, y: 728.8), controlPoint2: CGPoint(x: 176.64, y: 982.4))
        addCurveToPoint(CGPoint(x: 998.58, y: 499.71), controlPoint1: CGPoint(x: 786.87, y: 1015.77), controlPoint2: CGPoint(x: 981.5, y: 802.06))
        addCurveToPoint(CGPoint(x: 573.4, y: 1.34), controlPoint1: CGPoint(x: 1015.67, y: 197.35), controlPoint2: CGPoint(x: 878.52, y: 18.02))
        addCurveToPoint(CGPoint(x: 1.05, y: 426.45), controlPoint1: CGPoint(x: 268.28, y: -15.35), controlPoint2: CGPoint(x: 18.13, y: 124.1))
        closePath()
        moveToPoint(CGPoint(x: 1.05, y: 426.45))
        usesEvenOddFillRule = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

