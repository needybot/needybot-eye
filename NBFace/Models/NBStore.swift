//
//  NBStore.swift
//  NBFace
//
//  Created by David Glivar on 9/12/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import CoreMotion
import Foundation
import UIKit

/**
    Singleton class representing the current state of the robot.
*/
class NBStore: NSObject {
    
    static let sharedInstance = NBStore()
    
    /// Handler for when new altimeter data is received
    var altimeterHandler: NBHandler!
    
    /// The current relative altitude of the iPad.
    var altitude: Float = 0.0
    
    /// The current battery level of the iPad - a Float value between 0 and 1. (Read only)
    var batteryLevel: Float {
        return UIDevice.currentDevice().batteryLevel
    }
    
    var id: NBIdentityMsg?
    var goal: String?
    var personType: [String: AnyObject]?
    
    override init() {
        super.init()
        
        altimeterHandler = NBHandler() { [weak self] args in
            guard let altitudeData = args[safe: 0] as? CMAltitudeData else {
                return
            }
            self?.handleAltimeterData(altitudeData)
        }
        
        NBAltimeterManager.defaultManager().addHandler(altimeterHandler)
        NBAltimeterManager.defaultManager().start()
    }
    
    // MARK: NBAltimeter handlers
    
    private func handleAltimeterData(altitudeData: CMAltitudeData) {
        altitude = Float(altitudeData.relativeAltitude)
    }
}