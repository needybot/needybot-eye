//
//  NBPoint2DMsg.swift
//  NBFace
//
//  Created by David Glivar on 4/4/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBPoint2DMsg: ROSMessage {
    
    private var _x: CGFloat
    private var _y: CGFloat
    
    mutating func x(x: CGFloat? = nil) -> CGFloat {
        guard let x = x else {
            return _x
        }
        _x = x
        return _x
    }
    
    mutating func y(y: CGFloat? = nil) -> CGFloat {
        guard let y = y else {
            return _y
        }
        _y = y
        return _y
    }
    
    static func Create(x: CGFloat, _ y: CGFloat) -> NBPoint2DMsg {
        return NBPoint2DMsg(_x: x, _y: y)
    }
    
    static func Default() -> ROSMessage {
        return NBPoint2DMsg(_x: 0, _y: 0)
    }
    
    func asMsg() -> [String : AnyObject] {
        return [
            "x": _x,
            "y": _y
        ]
    }
}