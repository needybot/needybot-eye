//
//  NBPathMsg.swift
//  NBFace
//
//  Created by David Glivar on 4/4/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBPathMsg: ROSMessage {
    
    private var _width: CGFloat
    private var _height: CGFloat
    private var _points: [NBPoint2DMsg]
    
    mutating func width(width: CGFloat? = nil) -> CGFloat {
        guard let width = width else {
            return _width
        }
        _width = width
        return _width
    }
    
    mutating func height(height: CGFloat? = nil) -> CGFloat {
        guard let height = height else {
            return _height
        }
        _height = height
        return _height
    }
    
    mutating func points(points: [NBPoint2DMsg]? = nil) -> [NBPoint2DMsg] {
        guard let points = points else {
            return _points
        }
        _points = points
        return _points
    }
    
    static func Default() -> ROSMessage {
        return NBPathMsg(_width: 0, _height: 0, _points: [NBPoint2DMsg]())
    }
    
    func asMsg() -> [String : AnyObject] {
        var arr = [AnyObject]()
        for point in _points {
            arr.append(point.asMsg())
        }
        return [
            "width": _width,
            "height": _height,
            "points": arr
        ]
    }
}