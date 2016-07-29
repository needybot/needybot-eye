//
//  EyePath.swift
//  NBEyeAnimation
//
//  Created by Nate Horstmann on 7/11/16.
//  Copyright © 2016 Nate Horstmann. All rights reserved.
//

import Foundation
import UIKit

class EyePath: UIBezierPath {
    override init() {
        super.init()
        
        moveToPoint(CGPoint(x: 1.26, y: 512.43))
        addCurveToPoint(CGPoint(x: 477.01, y: 998.52), controlPoint1: CGPoint(x: 24.83, y: 802.36), controlPoint2: CGPoint(x: 218.46, y: 975.93))
        addCurveToPoint(CGPoint(x: 999.93, y: 474.7), controlPoint1: CGPoint(x: 735.57, y: 1021.1), controlPoint2: CGPoint(x: 995.2, y: 783.09))
        addCurveToPoint(CGPoint(x: 539.78, y: 0.83), controlPoint1: CGPoint(x: 1004.16, y: 198.7), controlPoint2: CGPoint(x: 821.47, y: 18.02))
        addCurveToPoint(CGPoint(x: 1.26, y: 512.43), controlPoint1: CGPoint(x: 258.09, y: -16.37), controlPoint2: CGPoint(x: -21.11, y: 237.24))
        closePath()
        moveToPoint(CGPoint(x: 1.26, y: 512.43))
        usesEvenOddFillRule = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}