//
//  ROSTopic.swift
//  ROSLibSwift
//
//  Created by David Glivar on 2/16/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

public class ROSTopic: NSObject {
    
    private var isAdvertised = false
    
    public var queueLength: Int
    public var subscribeHandler: ROSHandler?
    public var throttleRate: Int
    public var topic: String
    public var type: String
    
    public init(topic: String, type: String, queueLength: Int = 10, throttleRate: Int = 0) {
        self.queueLength = queueLength
        self.throttleRate = throttleRate
        self.topic = topic
        self.type = type
        super.init()
    }
    
    public func subscribe(handler: ROSHandler) {
        subscribeHandler = handler
        let message: [String: AnyObject] = [
            "op": "subscribe",
            "topic": topic,
            "type": type,
            "throttle_rate": throttleRate,
            "queue_length": queueLength,
        ]
        ROS.sharedInstance.registerSubscriber(self)
        ROS.sharedInstance.send(ROS.objectToJSONString(message))
    }
    
    public func unsubscribe() {
        subscribeHandler = nil
        let message: [String: AnyObject] = [
            "op": "unsubscribe",
            "topic": topic
        ]
        ROS.sharedInstance.unregisterSubscriber(self)
        ROS.sharedInstance.send(ROS.objectToJSONString(message))
    }
    
    public func advertise() {
        if isAdvertised {
            return
        }
        let message: [String: AnyObject] = [
            "op": "advertise",
            "topic": topic,
            "type": type,
        ]
        ROS.sharedInstance.send(ROS.objectToJSONString(message))
        isAdvertised = true
    }
    
    public func unadvertise() {
        if !isAdvertised {
            return
        }
        let message: [String: AnyObject] = [
            "op": "unadvertise",
            "topic": topic
        ]
        ROS.sharedInstance.send(ROS.objectToJSONString(message))
        isAdvertised = false
    }
    
    public func publish(msg: [String: AnyObject]) {
        if !isAdvertised {
            advertise()
        }
        let message: [String: AnyObject] = [
            "op": "publish",
            "topic": topic,
            "msg": msg
        ]
        if topic == "/needybot/msg/response" {
            NB.log("publishing: \(message.description)")
        }
        ROS.sharedInstance.send(ROS.objectToJSONString(message))
    }
}