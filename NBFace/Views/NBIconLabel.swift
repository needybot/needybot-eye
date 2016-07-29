//
//  NBIconLabel.swift
//  NBFace
//
//  Created by David Glivar on 5/27/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

class NBIconLabel: NBView {
    
    var icon: UIImageView!
    var label = UILabel()
    
    convenience init(icon: String, text: String, xoffset: CGFloat = 0, yoffset: CGFloat = 0) {
        self.init(frame: CGRectMake(0, 0, NB.FRAME.width, 50))
        guard let image = UIImage(named: icon) else {
            NB.log("unknown image id: \(icon)")
            return
        }
        
        self.icon = UIImageView(image: image)
        
        var trans = CGAffineTransformMakeScale(0.5, 0.5)
        trans = CGAffineTransformTranslate(trans, xoffset, yoffset)
        self.icon.transform = trans
        
        label.text = text
        label.font = UIFont(name: NB.Font.MavenProBold.rawValue, size: 21)
        label.numberOfLines = 1
        label.textColor = NB.Colors.OffWhite
        label.frame.size = CGSizeMake(NB.FRAME.width, 50)
        label.frame.origin = CGPointMake(48, -3)
        
        addSubview(self.icon)
        addSubview(label)
        sizeToFit()
    }
}