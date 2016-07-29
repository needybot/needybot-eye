//
//  NBDebugView.swift
//  NBFace
//
//  Created by David Glivar on 3/17/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

class NBDebugView: NBView {
    
    let outline = CAShapeLayer()
    let crosshair = CAShapeLayer()
    
    convenience init() {
        self.init(frame: NB.FRAME)
        
        userInteractionEnabled = false
        
        let crosshairPath = UIBezierPath()
        crosshairPath.moveToPoint(CGPointMake(NB.FRAME.width * 0.5, 0))
        crosshairPath.addLineToPoint(CGPointMake(NB.FRAME.width * 0.5, NB.FRAME.height))
        crosshairPath.moveToPoint(CGPointMake(0, NB.FRAME.height * 0.5))
        crosshairPath.addLineToPoint(CGPointMake(NB.FRAME.width, NB.FRAME.height * 0.5))
        
        crosshair.path = crosshairPath.CGPath
        crosshair.strokeColor = UIColor.redColor().CGColor
        
        outline.path = NBShape.createPath(NBShape.Debug.Outline).CGPath
        outline.backgroundColor = UIColor(0, 0, 0, 0.2).CGColor
        outline.strokeColor = UIColor.whiteColor().CGColor
        outline.fillColor = UIColor.clearColor().CGColor
        
        outline.transform = CATransform3DScale(outline.transform, 0.5, 0.5, 0)
        
        outline.frame.origin.y = NB.FRAME.height * 0.5 - NBShape.sizeOfShape(NBShape.Debug.Outline).height * 0.25
        
        layer.addSublayer(outline)
        layer.addSublayer(crosshair)
    }
}