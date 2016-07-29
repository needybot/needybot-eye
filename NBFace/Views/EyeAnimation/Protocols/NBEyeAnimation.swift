//
//  NBEyeAnimation.swift
//  NBFace
//
//  Created by Nate Horstmann on 7/18/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

protocol NBEyeAnimation {
    var animationView: NBEyeAnimationView { get }
    
    func animate()
}


