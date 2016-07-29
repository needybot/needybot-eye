//
//  NBEyeIdle.swift
//  NBFace
//
//  Created by Nate Horstmann on 7/20/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

class NBEyeIdle: NSObject, NBEyeAnimation {
    
    var animationView: NBEyeAnimationView
    
    init(animationView: NBEyeAnimationView) {
        self.animationView = animationView
        super.init()
    }
    
    // TODO: make the CA specific animation code gneerated based on a set of more simple instructions
    
    func animate() {
        let duration = CFTimeInterval(1)
        
        let eyeLayer = animationView.eyeLayer
        let corneaLayer = animationView.corneaLayer
        let irisDiffuseLayer = animationView.irisDiffuseLayer
        
        // =================================================================
        // main eye animation
        // =================================================================
        //  - eye scale
        let eyeScaleAnim = CAKeyframeAnimation(keyPath: "transform")
        let eyeScaleAnimKeyTimesSeconds = [0, CGFloat(duration)]
        let eyeScaleAnimValues: [CGFloat] = [
            NBAnimation.getScale(eyeLayer).x,
            NBAnimation.EyeValues.ScaleEyeIdle
        ]
        eyeScaleAnim.keyTimes = NBAnimation.getKeyTimes(eyeScaleAnimKeyTimesSeconds, CGFloat(duration))
        eyeScaleAnim.values = NBAnimation.getCAValues2DScale(eyeScaleAnimValues)
        eyeScaleAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        eyeScaleAnim.duration = duration
        eyeLayer.addAnimation(eyeScaleAnim, forKey: NBAnimation.AnimationKey.Eye.rawValue)
        // update layer model with final values
        eyeLayer.transform = CATransform3DMakeScale(eyeScaleAnimValues.last!, eyeScaleAnimValues.last!, 1.0)
        
        // =================================================================
        // cornea animation
        // =================================================================
        //  - cornea scale
        let corneaScaleAnim = CAKeyframeAnimation(keyPath: "transform")
        let corneaScaleAnimKeyTimesSeconds: [CGFloat] = [0, CGFloat(duration)]
        let corneaScaleAnimValues: [CGFloat] = [
            NBAnimation.getScale(corneaLayer).x,
            NBAnimation.EyeValues.ScaleCorneaIdle
        ]
        corneaScaleAnim.keyTimes = NBAnimation.getKeyTimes(corneaScaleAnimKeyTimesSeconds, CGFloat(duration))
        corneaScaleAnim.values = NBAnimation.getCAValues2DScale(corneaScaleAnimValues)
        corneaScaleAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        
        // - cornea position
        let corneaPosAnim = CAKeyframeAnimation(keyPath:"position")
        let corneaPosAnimKeyTimesSeconds: [CGFloat] = [0, CGFloat(duration)]
        let corneaFromPos = NBAnimation.getPosition(corneaLayer)
        let corneaEndPos = CGPoint(x: 500.0, y: 500.0)
        let corneaPosAnimValues = [
            corneaFromPos,
            corneaEndPos
        ]
        corneaPosAnim.keyTimes = NBAnimation.getKeyTimes(corneaPosAnimKeyTimesSeconds, CGFloat(duration))
        corneaPosAnim.values = NBAnimation.getCAValuesPosition(corneaPosAnimValues)
        corneaPosAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        
        let corneaAnimGroup: CAAnimationGroup = CAAnimationGroup()
        corneaAnimGroup.animations = [corneaPosAnim, corneaScaleAnim]
        corneaAnimGroup.duration = duration
        corneaLayer.addAnimation(corneaAnimGroup, forKey: NBAnimation.AnimationKey.Cornea.rawValue)
        // update layer model with final values
        corneaLayer.position = corneaEndPos
        corneaLayer.transform = CATransform3DMakeScale(corneaScaleAnimValues.last!, corneaScaleAnimValues.last!, 1.0)
        
        // =================================================================
        // iris animation
        // =================================================================
        let irisAnim = CABasicAnimation(keyPath: "fillColor")
        irisAnim.timingFunction = UIView.functionWithType(CustomTimingFunctionQuadIn)
        irisAnim.duration = 0.5
        irisAnim.toValue = NBEyeAnimationView.EyeColors.IrisIdle.CGColor
        irisDiffuseLayer.addAnimation(irisAnim, forKey: NBAnimation.AnimationKey.Iris.rawValue)
        irisDiffuseLayer.fillColor = NBEyeAnimationView.EyeColors.IrisIdle.CGColor
        
        // =================================================================
        // eyelid animation
        // =================================================================
        let eyelidUpperAnim = CAKeyframeAnimation(keyPath: "path")
        let eyelidUpperCurrentPath = NBAnimation.getPresentationShapeLayer(animationView.eyelidUpperLayer).path!
        let eyelidUpperAnimKeyTimesSeconds: [CGFloat] = [0, 1.5]
        let eyelidUpperAnimValues: [CGPath] = [
            eyelidUpperCurrentPath,
            EyelidPaths.UpperIdleOpen.CGPath
        ]
        eyelidUpperAnim.keyTimes = NBAnimation.getKeyTimes(eyelidUpperAnimKeyTimesSeconds, 1.5)
        eyelidUpperAnim.values = eyelidUpperAnimValues
        eyelidUpperAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        animationView.eyelidUpperLayer.addAnimation(eyelidUpperAnim, forKey: NBAnimation.AnimationKey.EyelidUpper.rawValue)
        animationView.eyelidUpperLayer.path = EyelidPaths.UpperIdleOpen.CGPath
        
        let eyelidLowerAnim = CAKeyframeAnimation(keyPath: "path")
        let eyelidLowerCurrentPath = NBAnimation.getPresentationShapeLayer(animationView.eyelidLowerLayer).path!
        let eyelidLowerAnimKeyTimesSeconds: [CGFloat] = [0, 1.5]
        let eyelidLowerAnimValues: [CGPath] = [
            eyelidLowerCurrentPath,
            EyelidPaths.LowerIdleOpen.CGPath
        ]
        eyelidLowerAnim.keyTimes = NBAnimation.getKeyTimes(eyelidLowerAnimKeyTimesSeconds, 1.5)
        eyelidLowerAnim.values = eyelidLowerAnimValues
        eyelidLowerAnim.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        animationView.eyelidLowerLayer.addAnimation(eyelidLowerAnim, forKey: NBAnimation.AnimationKey.EyelidLower.rawValue)
        animationView.eyelidLowerLayer.path = EyelidPaths.LowerIdleOpen.CGPath
    }
}