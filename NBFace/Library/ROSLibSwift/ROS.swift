//
//  ROS.swift
//  ROSLibSwift
//
//  Created by David Glivar on 2/15/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import SocketRocket

public class ROS: NSObject, SRWebSocketDelegate {
    
    public static let sharedInstance = ROS()
    
    private var connectCallback: ROSHandler?
    private var connectTimer: NSTimer?
    private var isConnected = false
    private var queue = [NSString]()
    private var services = [ROSService]()
    private var socket: SRWebSocket?
    private var subscribers = [ROSTopic]()
    private var url: String?
    private var nsurl: NSURL?
    
    public static func fromJSON(jsonString: String) -> [String: AnyObject]? {
        guard let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) else {
            return nil
        }
        return json as? [String: AnyObject]
    }
    
    public static func template(key: String, _ value: String, _ isRaw: Bool = false) -> String {
        if isRaw {
            return "\"\(key)\": \(value)"
        }
        return "\"\(key)\": \"\(value)\""
    }
    
    public static func objectToJSONString(object: [String: AnyObject]) -> String {
        var arr: [String] = []
        
        for (k, v) in object {
            // handle nested objects
            if let val = v as? [String: AnyObject] {
                let s = template(k, objectToJSONString(val), true)
                arr.append(s)
                continue
            }
            
            if let val = v as? [[String: AnyObject]] {
                var a = [String]()
                for n in val {
                    a.append(objectToJSONString(n))
                }
                arr.append("\"\(k)\": [\(a.joinWithSeparator(","))]")
                continue
            }
            
            // handle array types
            if let val = v as? [AnyObject] {
                var s: String = ""
                if let val = val as? [String] {
                    var a = [String]()
                    for n in val {
                        a.append("\"\(n)\"")
                    }
                    s = "\"\(k)\": [\(a.joinWithSeparator(","))]"
                } else {
                    s = template(k, "\(val)", true)
                }
                arr.append(s)
                continue
            }
            
            // handle strings
            if let val = v as? String {
                arr.append(template(k, val))
                continue
            }
            
            // handle floats and ints
            if let val = v as? Float64 {
                let isInt = String(v) != String(val)
                if isInt {
                    arr.append(template(k, "\(Int(val))", true))
                    continue
                }
                arr.append(template(k, "\(val)", true))
                continue
            }
            
            // handle booleans
            if let val = v as? Bool {
                arr.append(template(k, "\(val)", true))
                continue
            }
        }
        
        let joined = arr.joinWithSeparator(", ")
        return "{ \(joined) }"
    }
    
    public func connect(url: String, _ callback: ROSHandler? = nil) /*throws*/ {
        guard let nsurl = NSURL(string: url) else {
            NSLog("Invalid connection url")
            return
        }
        if let cb = callback {
            connectCallback = cb
        }
        NB.log("Preparing to connect to ROS on url \(url) ...")
        self.nsurl = nsurl
        self.url = url
        connectTimer = NSTimer.schedule(repeatInterval: 5.0) { timer in
            if !self.isConnected {
                NSLog("ROS is not connected, retrying in 5 seconds...")
                self.socket = SRWebSocket(URL: nsurl)
                self.socket?.delegate = self
                self.socket?.open()
            } else {
                timer.invalidate()
            }
        }
    }
    
    public func close() {
        socket?.close()
    }
    
    public func registerService(service: ROSService) -> Bool {
        guard let _ = services.indexOf(service) else {
            services.append(service)
            return true
        }
        return false
    }
    
    public func registerSubscriber(topic: ROSTopic) -> Bool {
        guard let _ = subscribers.indexOf(topic) else {
            subscribers.append(topic)
            return true
        }
        return false
    }
    
    public func send(message: String) {
        let message = NSString(string: message)
        if !isConnected {
            queue.append(message)
            return
        }
        socket?.send(message)
    }
    
    public func sendNSString(message: NSString) {
        if !isConnected {
            queue.append(message)
            return
        }
        socket?.send(message)
    }
    
    public func unregisterService(service: ROSService) -> Bool {
        guard let idx = services.indexOf(service) else {
            return false
        }
        services.removeAtIndex(idx)
        return true
    }
    
    public func unregisterSubscriber(topic: ROSTopic) -> Bool {
        guard let idx = subscribers.indexOf(topic) else {
            return false
        }
        subscribers.removeAtIndex(idx)
        return true
    }
    
    public func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        guard let message = message as? String,
            let msg = ROS.fromJSON(message) else {
                return
        }
        if let topicName = msg["topic"] as? String {
            for subscriber in subscribers {
                if subscriber.topic != topicName {
                    continue
                }
                subscriber.subscribeHandler?.handle(msg)
            }
        } else if let serviceName = msg["service"] as? String {
            guard let id = msg["id"] as? String else {
                NSLog("No id in service response")
                return
            }
            for service in services {
                if service.service != serviceName || service.id != id {
                    continue
                }
                service.serviceCallback?.handle(msg)
                unregisterService(service)
            }
        }
    }
    
    public func webSocketDidOpen(webSocket: SRWebSocket!) {
        NSLog("ROSLibSwift connected to \(url!)")
        connectTimer?.invalidate()
        isConnected = true
        connectCallback?.handle([:])
        for message in queue {
            sendNSString(message)
        }
    }
    
    public func webSocket(webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        NSLog("ROS disconnected with code: \(code), reason: \(reason)")
        guard let url = url else { return }
        NSLog("Attempting to reconnect...")
        connectTimer?.invalidate()
        isConnected = false
        connect(url)
    }
}