//
//  NBFaceRecognizeRequestMsg.swift
//  NBFace
//
//  Created by David Glivar on 2/23/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

struct NBFaceRecognizeRequestMsg: ROSMessage {
    
    private var _image: NBBase64ImageMsg
    
    mutating func image(image: NBBase64ImageMsg? = nil) -> NBBase64ImageMsg {
        guard let image = image else {
            return _image
        }
        _image = image
        return _image
    }
    
    // MARK: - ROSMessage implementation
    
    static func Default() -> ROSMessage {
        return NBFaceRecognizeRequestMsg(_image: NBBase64ImageMsg.Default() as! NBBase64ImageMsg)
    }
    
    func asMsg() -> [String : AnyObject] {
        return [
            "image": _image.asMsg()
        ]
    }
}