//
//  NB.swift
//  NBFace
//
//  Created by David Glivar on 8/3/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

/**
    A struct containing utility methods, types, and properties.
*/
struct NB {
    
    /// Convenience typealias for a closure with no parameters and no return value
    typealias Callback = () -> ()
    
    /**
        The frame to be used on any fullscreen view. Uses the `y_offset` property
        in our settings bundle.
    */
    static var FRAME: CGRect = CGRectMake(
        0,
        CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("y_offset")),
        UIScreen.mainScreen().bounds.width,
        UIScreen.mainScreen().bounds.height
    )
    
    static let ANIMATION_DURATION: NSTimeInterval = 0.25
//    static let ANIMATION_DURATION: NSTimeInterval = 0.5
    
    enum Font: String {
        case MavenProBold
        case KarmaRegular = "Karma-Regular"
        case KarmaMedium = "Karma-Medium"
        case KarmaLight = "Karma-Light"
        case KarmaBold = "Karma-Bold"
        case KarmaSemibold = "Karma-Semibold"
    }
    
    enum InputType: String {
        case Confirm
        case LostAlert
        case MainMenu
        
        static func fromString (inputType: String) -> InputType? {
            switch inputType {
            case "confirm":
                return InputType.Confirm
            case "lostAlert":
                return InputType.LostAlert
            case "mainMeny":
                return InputType.MainMenu
            default:
                return nil
            }
        }
    }
    
    enum EyeEmotion: String {
        case Celebrate
        case Happy
        case Idle
        case Sad
        
        static func fromString (inputType: String) -> EyeEmotion? {
            switch inputType {
            case "happy":
                return EyeEmotion.Happy
            case "sad":
                return EyeEmotion.Sad
            case "idle":
                return EyeEmotion.Idle
            default:
                return nil
            }
        }
    }
    

    /**
        Utility logging method. When provided a `caller` it pretty prints the log.
        - Parameter message: The message to be logged
        - Parameter caller: Optional type to be referenced in the log message
        
        **Example**
    
        ```swift
        NB.log("Ok", caller: NBRootViewController.self)
        // => [NBRootViewController]: Ok
        ```
    */
    static func log(message: String, caller: Any? = nil) {
        var msg = ""
        if let caller = caller {
            msg += "[\(caller.self)]: "
        }
        msg += message
        NSLog("%@", msg)
    }
    
    /**
        Utility method for combining two Dictionary's into a new single Dictionary.
        (Non mutating)
        - Parameter left: The source dictionary
        - Parameter right: The dictionary to merge into the source dictionary
        - Returns: Dictionary<K, V>
    
        **Example**
        ```swift
        let result = NB.mergeDicts(["source": true], ["foo": "bar"])
        ```
    */
    static func mergeDicts<K, V>(left: Dictionary<K, V>, _ right: Dictionary<K, V>) -> Dictionary<K, V> {
        var map = Dictionary<K, V>()
        for (k, v) in left {
            map[k] = v
        }
        for (k, v) in right {
            map[k] = v
        }
        return map
    }
    
    /**
        Utility function that returns an empty `NB.Callback`, producing a
        'no operation' closure.
        - Returns: NB.Callback
    */
    static func noop() -> NB.Callback {
        return {}
    }
    
    /**
     Method that returns a random Double given a min and max value
    **/
    static func rand(min: Double, max: Double) -> Double {
        return min + (Double(arc4random_uniform(1001))/1000 * (max - min))
    }
    
    /**
        Method that returns a random integer within given a range (inclusive).
        - Parameter range: The range to generate the random integer
        - Returns: UInt32
        
        **Examples**
        
        ```swift
        // normal implementation
        let i: UInt32 = NB.randomInRange(0...5)
    
        // array subscript value
        let i: Int = Int(NB.randomInRange(0...3))
        let result = myArray[i]
        ```
    */
    static func randomInRange(range: Range<UInt32>) -> UInt32 {
        return range.startIndex + arc4random_uniform(range.endIndex - range.startIndex)
    }
    
    /**
        Method that returns either 1 or -1
        - Returns: Int
    */
    static func randomSign() -> Int {
        return arc4random_uniform(2) == 1 ? 1 : -1
    }
    
    struct Colors {
        static let Charcoal = UIColor(96, 96, 95, 1.0)
        static let OffWhite = UIColor(255, 255, 248, 1.0)
        static let Red = UIColor(255, 109, 91, 1.0)
        static let Shadow = UIColor(80, 86, 86, 1.0)
        static let WhiteReflection = UIColor(193, 193, 186, 0.25)
        
        static let Background = UIColor(22, 22, 20, 1.0)
        static let ButtonShadow = UIColor(80, 86, 86, 1.0)
        static let UIBackground = UIColor(92, 102, 102, 1.0)
        static let Happy = UIColor(39, 235, 175, 1.0)
        static let Meh = UIColor(95, 189, 198, 1.0)
        static let Sad = UIColor(106, 133, 195, 1.0)
        
        static let Pink = UIColor(253, 107, 142, 1.0)
        
        static let Orange = UIColor(254, 122, 74, 1.0)
        static let Gold = UIColor(250, 180, 70, 1.0)
        static let Blue = UIColor(91, 132, 246, 1.0)
        
        static func fromWord (colorName: String) -> UIColor {
            switch colorName {
                case "orange":
                    return Colors.Orange
                case "gold":
                    return Colors.Gold
                case "blue":
                    return Colors.Blue
                default:
                    return UIColor(255, 0, 255, 1.0)
            }
        }
    }
    
    enum ResizingBehavior {
        case AspectFit // The content is proportionally resized to fit into the target rectangle.
        case AspectFill // The content is proportionally resized to completely fill the target rectangle.
        case Stretch // The content is stretched to match the entire target rectangle.
        case Center // The content is centered in the target rectangle, but it is NOT resized.
        
        func apply(rect rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .AspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .AspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .Stretch:
                break
            case .Center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    
}