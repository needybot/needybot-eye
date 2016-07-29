//
//  NBAltimeter.swift
//  NBFace
//
//  Created by David Glivar on 8/28/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import CoreMotion
import Foundation

class NBAltimeterManager: NBManager {
    
    let altimeter = CMAltimeter()
    var handlers = [NBHandler]()
    
    static var _defaultManager: NBAltimeterManager?
    static func defaultManager() -> NBAltimeterManager {
        if let manager = _defaultManager {
            return manager
        }
        _defaultManager = NBAltimeterManager()
        return _defaultManager!
    }
    
    func handleAltitudeUpdate(data: CMAltitudeData) {
        runStack(data)
    }
    
    func start() -> Bool {
        if !CMAltimeter.isRelativeAltitudeAvailable() {
            NB.log("Altimeter data is not available for this device.", caller: NBAltimeterManager.self)
            return false
        }
        
        guard let currentQueue = NSOperationQueue.currentQueue() else {
            return false
        }
        
        altimeter.startRelativeAltitudeUpdatesToQueue(currentQueue) { [weak self] altitudeData, error in
            if let error = error {
                NB.log("error: \(error.userInfo)", caller: NBAltimeterManager.self)
                return
            }
            guard let data = altitudeData else { return }
            self?.handleAltitudeUpdate(data)
        }
        
        return true
    }
    
    func stop() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}