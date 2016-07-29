//
//  NBIdentityMsg.swift
//  NBFace
//
//  Created by David Glivar on 3/7/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBIdentityMsg: ROSMessage {
    
    enum Types: Int {
        case None, Training, Recognition
    }
    
    private var _fullname: String
    private var _type: Int
    private var _uuid: String
    
    mutating func fullname(fullname: String? = nil) -> String {
        guard let fullname = fullname else {
            return _fullname
        }
        _fullname = fullname
        return _fullname
    }
    
    mutating func type(type: NBIdentityMsg.Types? = nil) -> Int {
        guard let type = type else {
            return _type
        }
        _type = type.rawValue
        return _type
    }
    
    mutating func uuid(uuid: String? = nil) -> String {
        guard let uuid = uuid else {
            return _uuid
        }
        guard let _ = NSUUID(UUIDString: uuid) else {
            NB.log("Invalid UUID, \(uuid)")
            return _uuid
        }
        _uuid = uuid
        return _uuid
    }
    
    // MARK: - ROSMessage implementation
    
    static func Default() -> ROSMessage {
        return NBIdentityMsg(_fullname: "", _type: 0, _uuid: "")
    }
    
    func asMsg() -> [String : AnyObject] {
        return [
            "fullname": _fullname,
            "uuid": _uuid,
            "type": _type,
        ]
    }
}