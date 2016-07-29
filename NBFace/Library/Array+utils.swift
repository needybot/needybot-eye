//
//  Array+utils.swift
//  NBFace
//
//  Created by David Glivar on 3/4/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

extension Array {
    
    /// eg: guard let item = myArray[safe: 3] else { return }
    subscript (safe index: UInt) -> Element? {
        return Int(index) < count ? self[Int(index)] : nil
    }
}