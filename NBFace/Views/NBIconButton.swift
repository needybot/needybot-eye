//
//  NBIconButton.swift
//  NBFace
//
//  Created by David Glivar on 4/5/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

class NBIconButton: UIControl, NBManager {
    
    private let ANIMATION_DURATION: NSTimeInterval = 0.15
    private let ANNOTATION_OFFSET: CGFloat = 25.0
    
    private var _scale: CGFloat = 1.0
    private var shadowOffset: CGFloat = 6.0
    
    let annotationLabel = UILabel()
    let backView = NBView()
    let borderWidth: CGFloat
    let container = NBView()
    let iconView = UIImageView()
    let shadowView = NBView()
    
    var handlers = [NBHandler]()
    var icon: UIImage!
    
    // MARK: - Computed properties
    
    var annotation: String? {
        get {
            return annotationLabel.text
        }
        set {
            annotationLabel.frame.size.width = NB.FRAME.width
            annotationLabel.text = newValue
            if newValue == nil || newValue == "" {
                annotationLabel.hidden = true
            } else {
                annotationLabel.hidden = false
                if let labelSize = annotationLabel.attributedText?.size() {
                    annotationLabel.frame.size.width = labelSize.width
                } else {
                    annotationLabel.frame.size.width = frame.size.width
                }
                annotationLabel.frame.centerInRectMut(frame, xOffset: 0, yOffset: radius + ANNOTATION_OFFSET)
            }
        }
    }
    
    private var _fontSize: CGFloat = 21.0
    var fontSize: CGFloat {
        get {
            return _fontSize
        }
        set {
            _fontSize = newValue
            annotationLabel.font = UIFont(name: NB.Font.MavenProBold.rawValue, size: _fontSize)
            if let labelSize = annotationLabel.attributedText?.size() {
                annotationLabel.frame.size = CGSizeMake(labelSize.width, _fontSize + 5)
            } else {
                annotationLabel.frame.size = CGSizeMake(frame.size.width, _fontSize + 5)
            }
            annotationLabel.frame.centerInRectMut(frame, xOffset: 0, yOffset: radius + ANNOTATION_OFFSET)
            setNeedsDisplay()
        }
    }
    
    var radius: CGFloat {
        return frame.size.width * scale * 0.5
    }
    
    var scale: CGFloat {
        get {
            return _scale
        }
        set {
            _scale = newValue
            transform = CGAffineTransformMakeScale(_scale, _scale)
        }
    }
    
    // MARK: - Initializers
    
    init?(withIconID _icon: String, borderWidth: CGFloat = 6, shadowOffset: CGFloat = 6) {
        self.borderWidth = borderWidth
        self.shadowOffset = shadowOffset
        super.init(frame: CGRectZero)
        guard let image = UIImage(named: _icon) else {
            return nil
        }
        common(image)
    }
    
    init(withUIImage image: UIImage, borderWidth: CGFloat = 6) {
        self.borderWidth = borderWidth
        super.init(frame: CGRectZero)
        common(image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common(image: UIImage) {
        frame.size = image.size
        container.frame = frame
        
        let cornerRadius: CGFloat = frame.size.width * 0.5
        
        icon = image
        iconView.contentMode = .ScaleAspectFit
        iconView.image = icon
        iconView.frame.size = icon.size
        iconView.layer.cornerRadius = cornerRadius
        iconView.layer.masksToBounds = true
        
        backView.frame.size = frame.size
        backView.layer.cornerRadius = cornerRadius
        backView.backgroundColor = UIColor.whiteColor()
        
        shadowView.frame.size = frame.size
        shadowView.frame.centerInRectMut(frame, xOffset: -shadowOffset, yOffset: shadowOffset)
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.backgroundColor = NB.Colors.ButtonShadow
        
        annotationLabel.textColor = NB.Colors.OffWhite
        annotationLabel.textAlignment = .Center
        annotationLabel.numberOfLines = 1
        fontSize = _fontSize
        
        container.userInteractionEnabled = false
        shadowView.userInteractionEnabled = false
        iconView.userInteractionEnabled = false
        backView.userInteractionEnabled = false
        annotationLabel.userInteractionEnabled = false
        
        container.addSubview(shadowView)
        container.addSubview(backView)
        container.addSubview(iconView)
        addSubview(container)
        addSubview(annotationLabel)
        
        addTarget(self, action: #selector(NBIconButton.handleTouchDown), forControlEvents: .TouchDown)
        addTarget(self, action: #selector(NBIconButton.handleTouchDragExit), forControlEvents: .TouchDragExit)
        addTarget(self, action: #selector(NBIconButton.handleTouchUpInside), forControlEvents: .TouchUpInside)
        addTarget(self, action: #selector(NBIconButton.handleTouchUpOutside), forControlEvents: .TouchUpOutside)
    }
    
    // MARK: - Public API
    
    func transitionToActive() {
        let borderWidth = self.borderWidth
        UIView.animateWithDuration(
            ANIMATION_DURATION,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { [weak self] in
                self?.container.transform = CGAffineTransformMakeScale(0.95, 0.95)
                self?.iconView.transform = CGAffineTransformMakeScale(0.85, 0.85)
                self?.shadowView.transform = CGAffineTransformMakeTranslation(borderWidth * 0.5, borderWidth * -0.5)
            }, completion: nil)
    }
    
    func transitionToDefault() {
        UIView.animateWithDuration(
            ANIMATION_DURATION,
            delay: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: { [weak self] in
                self?.container.transform = CGAffineTransformMakeScale(1, 1)
                self?.iconView.transform = CGAffineTransformMakeScale(1, 1)
                self?.shadowView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
    
    // MARK: - UIControlEvent handlers
    
    func handleTouchDown() {
        transitionToActive()
    }
    
    func handleTouchDragExit() {
        transitionToDefault()
    }
    
    func handleTouchUpInside() {
        transitionToDefault()
        runStack()
    }
    
    func handleTouchUpOutside() {
        transitionToDefault()
    }
}