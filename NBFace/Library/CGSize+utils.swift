//
//  CGSize+utils.swift
//  NBFace
//
//  Created by David Glivar on 3/17/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

func +(left: CGSize, right: CGSize) -> CGSize {
    var size = CGSizeZero
    size.width = left.width + right.width
    size.height = left.height + right.height
    return size
}

func *(left: CGSize, right: CGFloat) -> CGSize {
    var size = CGSizeZero
    size.width = left.width * right
    size.height = left.height * right
    return size
}