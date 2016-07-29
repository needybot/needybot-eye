//
//  UIImage+utils.swift
//  NBFace
//
//  Created by David Glivar on 4/20/16.
//  Copyright © 2016 Wieden+Kennedy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // from http://stackoverflow.com/questions/32041420/cropping-image-with-swift-and-put-it-on-center-position
    static func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    // https://gist.github.com/justinlevi/ee037a4bb63598f6e56f
    
    func RBSquareImageTo(size: CGSize, dx: CGFloat = 0, dy: CGFloat = 0) -> UIImage? {
        return self.RBSquareImage(dx, dy: dy)?.RBResizeImage(size)
    }
    
    func RBSquareImage(dx: CGFloat = 0, dy: CGFloat = 0) -> UIImage? {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = ((originalWidth  - edge) / 2.0) + dx
        let posY = ((originalHeight - edge) / 2.0) + dy
        
        let cropSquare = CGRectMake(posX, posY, edge, edge)
        
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare);
        return UIImage(CGImage: imageRef!, scale: UIScreen.mainScreen().scale, orientation: self.imageOrientation)
    }
    
    func RBResizeImage(targetSize: CGSize, dx: CGFloat = 0, dy: CGFloat = 0) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(dx, dy, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.mainScreen().scale)
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}