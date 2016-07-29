//
//  ROSService.swift
//  NBFace
//
//  Created by David Glivar on 2/26/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

public class ROSService: NSObject {
    
    public let op = "call_service"
    public let service: String
    public let type: String
    
    public var args: [String: AnyObject]?
    public var id = NSUUID().UUIDString
    public var serviceCallback: ROSHandler?
    
    init(service: String, type: String, args: [String: AnyObject]?) {
        self.service = service
        self.type = type
        self.args = args
    }
    
    public func callService(callback: ROSHandler?) {
        var message: [String: AnyObject] = [
            "op": op,
            "service": service,
            "id": id
        ]
        if let args = args {
            message["args"] = args
        }
        serviceCallback = callback
        let payload = ROS.objectToJSONString(message)
        ROS.sharedInstance.registerService(self)
        ROS.sharedInstance.send(payload)
    }
}