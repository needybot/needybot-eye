//
//  NBInputView.swift
//  NBFace
//
//  Created by Nate Horstmann on 7/29/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation

protocol NBInputViewConfigurable {
    func show(withData data: [String: AnyObject]?)
}

class NBInputView: NBView {
    var isActive = false
    
    func activate() {
        isActive = true
    }
    
    func deactivate() {
        isActive = false
    }
    
    override func show() {
        activate()
        super.show()
    }
    
    override func hide() {
        deactivate()
        super.hide()
    }
}