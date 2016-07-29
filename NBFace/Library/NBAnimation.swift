//
//  NBAnimation.swift
//  NBFace
//
//  Created by Nate Horstmann on 7/19/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBAnimation {
    
    static let TWO_PI = 2.0 * M_PI
    
    /**
     Method used to attempt unwrapping a layer's presentation layer.
     - Parameter layer: The layer to get presentationLayer from
     */
    static func getPresentationLayer(layer: CALayer) -> CALayer {
        if let presentationLayer = layer.presentationLayer() as? CALayer {
            return presentationLayer
        }
        
        // fallback to the existing layer
        return layer
    }
    
    /**
     Method used to attempt unwrapping a shape layer's presentation layer.
     - Parameter layer: The shape layer to get presentationLayer from
     */
    static func getPresentationShapeLayer(layer: CAShapeLayer) -> CAShapeLayer {
        if let presentationLayer = layer.presentationLayer() as? CAShapeLayer {
            return presentationLayer
        }
        
        // fallback to the existing layer
        return layer
    }
    
    /**
     Utility method to get the position for a layer. Will attempt to read from the
     layer's presentationLayer to get the current animated value.
     - Parameter layer: The layer to read from
     */
    static func getPosition(layer: CALayer) -> CGPoint {
        let layer = self.getPresentationLayer(layer)
        return layer.position
    }
    
    /**
     Utility method to get the transform for a layer. Will attempt to read from the
     layer's presentationLayer to get the current animated value.
     - Parameter layer: The layer to read from
     */
    static func getTransform(layer: CALayer) -> CGAffineTransform {
        let layer = self.getPresentationLayer(layer)
        return CATransform3DGetAffineTransform(layer.transform)
    }
    
    /**
     Utility method to get the scale for a layer. Will attempt to read from the
     layer's presentationLayer to get the current animated value.
     - Parameter layer: The layer to read from
     */
    static func getScale(layer: CALayer) -> CGPoint {
        let transform = self.getTransform(layer)
        return CGPoint(x: transform.a, y: transform.d)
    }

    /**
      Utility method to get an keyTime based on an elapsed time in seconds normalized
      to a duration in seconds used for setting keyTimes array on CAKeyframeAnimation
     */
    static func getKeyTimes(elapsedTimes:[CGFloat], _ duration:CGFloat) -> [CGFloat] {
        return elapsedTimes.map({ $0/duration })
    }
    
    /**
     Utility method to get an array of CATransform3D scales wrapped in NSValues
     from an array of CGFloat scales
     */
    static func getCAValues2DScale(scaleValues: [CGFloat]) -> [NSValue] {
        return scaleValues.map({
            NSValue(CATransform3D: CATransform3DMakeScale($0, $0, 1.0))
        })
    }
    
    /**
     Utility method to get an array of CGPoint positions wrapped in NSValues
     */
    static func getCAValuesPosition(positionValues: [CGPoint]) -> [NSValue] {
        return positionValues.map({ NSValue(CGPoint: $0) })
    }
    
    /**
     Animation Keys used to add animation to NBEyeAnimation layers
     */
    enum AnimationKey: String {
        case Eye = "animateEye"
        case Cornea = "animateCornea"
        case Iris = "animationIris"
        case EyelidUpper = "animationEyelidUpper"
        case EyelidLower = "animationEyelidLower"
    }
    
    /**
     Utility method to get a random angle within a full rotation
     */
    static func getRandomAngle() -> CGFloat {
        return CGFloat(NB.rand(0.0, max: TWO_PI))
    }
    
    /**
     Predefined angle values that can be used when animating eye position
     */
    struct EyeLookAngles {
        static let Right = CGFloat(0)
        static let DownRight = CGFloat(TWO_PI * 0.125)
        static let Down = CGFloat(TWO_PI * 0.25)
        static let DownLeft = CGFloat(TWO_PI * 0.375)
        static let Left = CGFloat(TWO_PI * 0.5)
        static let UpLeft = CGFloat(TWO_PI * 0.625)
        static let UpRight = CGFloat(TWO_PI * 0.875)
        static let Up = CGFloat(TWO_PI * 0.75)
    }
    
    /**
     Predefined values used when animating eye layer properties to different states
     */
    struct EyeValues {
        static let ScaleEyeIdle: CGFloat = 1.0
        static let ScaleCorneaIdle: CGFloat = 0.6
        static let ScalePupilIdle: CGFloat = 0.72
    }

}