//
//  NBFaceResponseMsg.swift
//  NBFace
//
//  Created by David Glivar on 3/7/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBFaceResponseMsg: ROSMessage {
    
    enum StatusTypes: String {
        case success, failure, timeout
    }
    
    private var _status: String
    private var _step: String
    
    static func Failure() -> NBFaceResponseMsg {
        var res = NBFaceResponseMsg.Default() as! NBFaceResponseMsg
        if let state = NBViewMachine.sharedInstance.state {
            res.step(state)
        }
        res.status(NBFaceResponseMsg.StatusTypes.failure)
        return res
    }
    
    static func Success() -> NBFaceResponseMsg {
        var res = NBFaceResponseMsg.Default() as! NBFaceResponseMsg
        if let state = NBViewMachine.sharedInstance.state {
            res.step(state)
        }
        res.status(NBFaceResponseMsg.StatusTypes.success)
        return res
    }

    mutating func status(status: NBFaceResponseMsg.StatusTypes? = nil) -> String {
        guard let status = status else {
            return _status
        }
        _status = status.rawValue
        return _status
    }
    
    mutating func step(step: String? = nil) -> String {
        guard let step = step else {
            return _step
        }
        _step = step
        return _step
    }
    
    // MARK: - ROSMessage implementation
    
    static func Default() -> ROSMessage {
        return NBFaceResponseMsg(_status: "", _step: "")
    }
    
    func asMsg() -> [String : AnyObject] {
        return [
            "status": _status,
            "step": _step,
        ]
    }
}