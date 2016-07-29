//
//  NBLayerView.swift
//  NBFace
//
//  Created by David Glivar on 9/9/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

class NBLayerView: NBView {
    
    convenience init() {
        self.init(frame: UIScreen.mainScreen().bounds)
        addImage(UIImage(), index: 0, hide: true)
    }
    
    // MARK: - Public API
    
    func addImage(image: UIImage, index: Int = 0, hide: Bool = false) -> UIImageView {
        let v = UIImageView()
        v.frame = self.frame
        v.image = image
        v.contentMode = .Center
        if hide {
            v.alpha = 0.0
        }
        insertSubview(v, atIndex: index)
        return v
    }
    
    func crossFadeImage(image: UIImage, duration: NSTimeInterval = 0.25, onComplete: NB.Callback = {}) {
        if let top: UIImageView = getTopView() {
            // attempting to replace with same image, call complete callback and return
            if top.image == image {
                onComplete()
                return
            }
            let bottom = addImage(image, index: 0, hide: true)
            UIView.animateWithDuration(
                duration,
                delay: 0,
                options: .CurveEaseInOut,
                animations: { _ in
                    top.alpha = 0.0
                    bottom.alpha = 1.0
                }) { _ in
                    top.removeFromSuperview()
                    onComplete()
                }
        }
    }
    
    func getTopView() -> UIImageView? {
        if subviews.count == 0 {
            return nil
        }
        return subviews[0] as? UIImageView
    }
    
    func swapImage(image: UIImage) {
        if let top: UIImageView = getTopView() {
            addImage(image, index: 0, hide: false)
            top.removeFromSuperview()
        } else {
            addImage(image, index: 0, hide: false)
        }
    }
}