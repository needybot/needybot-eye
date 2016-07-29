//
//  NBBase64ImageMsg.swift
//  NBFace
//
//  Created by David Glivar on 2/23/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

struct NBBase64ImageMsg: ROSMessage {
    
    private var _encoded: String
    
    mutating func encoded(image: UIImage? = nil) -> String {
        guard let image = image else {
            return _encoded
        }
        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else {
            NB.log("Could not create b64 version of image: \(image.description)")
            return _encoded
        }
        _encoded = imageData.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
        return _encoded
    }
    
    // MARK: - ROSMessage implementation
    
    static func Default() -> ROSMessage {
        return NBBase64ImageMsg(_encoded: "")
    }
    
    func asMsg() -> [String : AnyObject] {
        return [
            "encoded": _encoded
        ]
    }
}