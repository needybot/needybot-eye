//
//  NBViewMachine.swift
//  NBFace
//
//  Created by David Glivar on 3/7/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Async
import Foundation

class NBViewMachine: NBStateMachine {
    
    static let sharedInstance = NBViewMachine()
    
    var root: NBRootViewController?
    
    var connectionURL: String? {
        return NSUserDefaults.standardUserDefaults().valueForKeyPath("rosbridge_url") as? String
    }
    let instruct = ROSTopic(topic: "/needybot/msg/instruct", type: "std_msgs/String", queueLength: 10, throttleRate: 750)
    let responsePub = ROSTopic(topic: "/needybot/msg/response", type: "needybot/FaceResponse", queueLength: 20)
    
    override init() {
        super.init()
        
        print("INIT")
        
        startupROS()
        
        // Subscribe to /needybot/msg/instruct and use the payload step as our
        // new state.
        instruct.subscribe(ROSHandler() { [weak self] data in
            guard let _msg = data["msg"] as? [String: AnyObject],
                let _json = _msg["data"] as? String,
                let msg = ROS.fromJSON(_json),
                let view = msg["view"] as? String,
                let type = msg["type"] as? String else {
                    NB.log("Unknown instruct message: \(data)")
                    return
            }
            
            NB.log("/needybot/msg/instruct ROSHandler:")
            NB.log(data.description)
            
            switch view {
            case "eye":
                // get emotion from type
                if let eyeEmotion = NB.EyeEmotion.fromString(type) {
                    self!.root?.setEyeEmotion(eyeEmotion)
                } else {
                    NB.log("No EyeEmotion exists for type: " + type)
                }
            
            case "ui":
                // read data used to configure ui view
                let viewData = msg["data"] as? [String: AnyObject]
                
                // get input type from type
                if let inputType = NB.InputType.fromString(type) {
                    self!.root?.setInputType(inputType, withData: viewData)
                } else {
                    NB.log("No InputType exists for type: " + type)
                }
            
            default:
                NB.log("No matching view to set with: " + view)
            }
        })
    }
    
    // MARK: -
    // MARK: Private Methods
    // TBD
    
    func startupROS() {
        guard let rosURL = connectionURL else {
            NSLog("ROS connection url was not provided, exiting.")
            return
        }
        
        
        ROS.sharedInstance.connect(rosURL, ROSHandler(){ data in
            NB.log("ROS connected!")
        })
    }
    
}