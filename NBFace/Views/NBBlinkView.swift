//
//  NBBlinkView.swift
//  NBFace
//
//  Created by David Glivar on 9/4/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Async
import Foundation
import UIKit

class NBBlinkView: NBView {
    
    let color = NB.Colors.Background.CGColor
//    let color = UIColor(255, 0, 0, 0.15).CGColor
    let toplid = CAShapeLayer()
    let botlid = CAShapeLayer()
    let duration = 0.25
    
    let botPathStart: UIBezierPath = {
        let p = UIBezierPath()
        let c = NB.FRAME.getCenter()
        let yoff = c.x * 0.5
        let cp1 = CGPoint(x: NB.FRAME.width * 0.375, y: c.y + c.x + yoff)
        let cp2 = CGPoint(x: NB.FRAME.width * 0.625, y: c.y + c.x + yoff)
        
        p.moveToPoint(CGPoint(x: 0, y: c.y + yoff))
        p.addLineToPoint(CGPoint(x: 10, y: c.y + yoff))
        p.addCurveToPoint(CGPoint(x: NB.FRAME.width - 10, y: c.y + yoff), controlPoint1: cp1, controlPoint2: cp2)
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y + yoff))
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y * 2))
        p.addLineToPoint(CGPoint(x: NB.FRAME.origin.x, y: c.y * 2))
        p.closePath()
        
        return p
    }()
    
    let botPathEnd: UIBezierPath = {
        let p = UIBezierPath()
        let c = NB.FRAME.getCenter()
        let cp1 = CGPoint(x: NB.FRAME.width * 0.375, y: c.y)
        let cp2 = CGPoint(x: NB.FRAME.width * 0.625, y: c.y)
        
        p.moveToPoint(CGPoint(x: 0, y: c.y))
        p.addLineToPoint(CGPoint(x: 10, y: c.y))
        p.addCurveToPoint(CGPoint(x: NB.FRAME.width - 10, y: c.y), controlPoint1: cp1, controlPoint2: cp2)
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y))
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y * 2))
        p.addLineToPoint(CGPoint(x: NB.FRAME.origin.x, y: c.y * 2))
        p.closePath()
        
        return p
    }()
    
    let topPathStart: UIBezierPath = {
        let p = UIBezierPath()
        let c = NB.FRAME.getCenter()
        let yoff: CGFloat = c.x * 0.5
        let cp1 = CGPoint(x: NB.FRAME.width * 0.375, y: c.y - c.x - yoff)
        let cp2 = CGPoint(x: NB.FRAME.width * 0.625, y: c.y - c.x - yoff)
        
        p.moveToPoint(CGPoint(x: 0, y: c.y - yoff))
        p.addLineToPoint(CGPoint(x: 10, y: c.y - yoff))
        p.addCurveToPoint(CGPoint(x: NB.FRAME.width - 10, y: c.y - yoff), controlPoint1: cp1, controlPoint2: cp2)
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y - yoff))
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: NB.FRAME.origin.y))
        p.addLineToPoint(CGPoint(x: NB.FRAME.origin.x, y: NB.FRAME.origin.y))
        p.closePath()
        
        return p
    }()
    
    let topPathEnd: UIBezierPath = {
        let p = UIBezierPath()
        let c = NB.FRAME.getCenter()
        let cp1 = CGPoint(x: NB.FRAME.width * 0.375, y: c.y)
        let cp2 = CGPoint(x: NB.FRAME.width * 0.625, y: c.y)
        
        p.moveToPoint(CGPoint(x: 0, y: c.y))
        p.addLineToPoint(CGPoint(x: 10, y: c.y))
        p.addCurveToPoint(CGPoint(x: NB.FRAME.width - 10, y: c.y), controlPoint1: cp1, controlPoint2: cp2)
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: c.y))
        p.addLineToPoint(CGPoint(x: NB.FRAME.width, y: NB.FRAME.origin.y))
        p.addLineToPoint(CGPoint(x: NB.FRAME.origin.x, y: NB.FRAME.origin.y))
        p.closePath()
        
        return p
    }()
    
    convenience init() {
        self.init(frame: NB.FRAME)
        userInteractionEnabled = false
        frame.origin.y += abs(NB.FRAME.origin.y)
        backgroundColor = UIColor.clearColor()
        
        toplid.fillColor = color
        toplid.strokeColor = color
        toplid.path = topPathStart.CGPath
        
        botlid.fillColor = color
        botlid.strokeColor = color
        botlid.path = botPathStart.CGPath
        
        layer.addSublayer(toplid)
        layer.addSublayer(botlid)
    }
    
    private func close() {
        let topCloseAnimation = CABasicAnimation(keyPath: "path")
        topCloseAnimation.timingFunction = UIView.functionWithType(CustomTimingFunctionQuadIn)
        topCloseAnimation.duration = duration * 0.5
        topCloseAnimation.fromValue = topPathStart.CGPath
        topCloseAnimation.toValue = topPathEnd.CGPath
        toplid.addAnimation(topCloseAnimation, forKey: "topCloseAnimation")
        
        let botCloseAnimation = CABasicAnimation(keyPath: "path")
        botCloseAnimation.timingFunction = UIView.functionWithType(CustomTimingFunctionQuadInOut)
        botCloseAnimation.duration = duration * 0.5
        botCloseAnimation.fromValue = botPathStart.CGPath
        botCloseAnimation.toValue = botPathEnd.CGPath
        botlid.addAnimation(botCloseAnimation, forKey: "botCloseAnimation")
        
        toplid.path = topPathEnd.CGPath
        botlid.path = botPathEnd.CGPath
    }
    
    private func open() {
        let topCloseAnimation = CABasicAnimation(keyPath: "path")
        topCloseAnimation.timingFunction = UIView.functionWithType(CustomTimingFunctionQuadIn)
        topCloseAnimation.duration = duration
        topCloseAnimation.fromValue = topPathEnd.CGPath
        topCloseAnimation.toValue = topPathStart.CGPath
        toplid.addAnimation(topCloseAnimation, forKey: "topCloseAnimation")
        
        let botCloseAnimation = CABasicAnimation(keyPath: "path")
        botCloseAnimation.timingFunction = UIView.functionWithType(CustomTimingFunctionQuadInOut)
        botCloseAnimation.duration = duration
        botCloseAnimation.fromValue = botPathEnd.CGPath
        botCloseAnimation.toValue = botPathStart.CGPath
        botlid.addAnimation(botCloseAnimation, forKey: "botCloseAnimation")
        
        toplid.path = topPathStart.CGPath
        botlid.path = botPathStart.CGPath
    }
    
    func blink(onClosed closedCallback: NB.Callback = {}, onOpen openCallback: NB.Callback = {}) {
        // cancel any ongoing blink
        
        close()
        Async.main(after: duration) {
            closedCallback()
        }.main {
            self.open()
        }.main(after: duration) {
            openCallback()
        }
    }
 }