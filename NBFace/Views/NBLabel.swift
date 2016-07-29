//
//  NBLabel.swift
//  NBFace
//
//  Created by Nate Horstmann on 5/25/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

class NBLabel: UILabel {
    
    private var _fontSize: CGFloat = 34.0
    var fontSize: CGFloat {
        get {
            return _fontSize
        }
        set {
            _fontSize = newValue
            font = UIFont(name: NB.Font.MavenProBold.rawValue, size: _fontSize)
            
            if let labelSize = attributedText?.size() {
                frame.size = CGSize(width: labelSize.width, height: labelSize.height)
            }
        }
    }
    
    convenience init(fontSize: CGFloat = 34.0) {
        self.init(text: "", fontSize: fontSize)
    }
    
    init(text: String, fontSize: CGFloat = 34.0, numberOfLines: Int = 1, fontName: String = NB.Font.MavenProBold.rawValue) {
        super.init(frame: CGRectZero)
        
        self.fontSize = fontSize
        textColor = NB.Colors.OffWhite
        textAlignment = .Center
        
        setText(text, numberOfLines: numberOfLines)
    }
    
    func setText(text: String, numberOfLines: Int = 1) {
        self.numberOfLines = numberOfLines
        self.text = text
        
        if let labelSize = attributedText?.size() {
            frame.size = CGSize(width: labelSize.width, height: labelSize.height)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}