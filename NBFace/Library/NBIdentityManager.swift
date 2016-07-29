//
//  NBIdentifier.swift
//  NBFace
//
//  Created by David Glivar on 8/13/15.
//  Copyright (c) 2015 Wieden+Kennedy. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

class NBIdentityManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    static var _defaultManager: NBIdentityManager?
    static func defaultManager() -> NBIdentityManager {
        if let manager = _defaultManager {
            return manager
        }
        _defaultManager = NBIdentityManager()
        return _defaultManager!
    }
    
    private enum Stack {
        case Detection, Preview
    }
    
    private let videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL)
    
    private var detector: CIDetector?
    private var detectionHandlers = [NBHandler]()
    private var device: AVCaptureDevice?
    private var deviceInput: AVCaptureDeviceInput?
    private var previewHandlers = [NBHandler]()
    private var session: AVCaptureSession?
    private var videoDataOutput: AVCaptureVideoDataOutput?
    
    override init() {
        super.init()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            setupAVCapture()
            detector = CIDetector(
                ofType: CIDetectorTypeFace,
                context: CIContext(options: [kCIContextUseSoftwareRenderer: true]),
                options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            )
        }
    }
    
    // MARK: Private methods
    
    private func processFeatures(features: [CIFeature], image: CGImage, videoRect: CGRect) {
        let angle = CGFloat(-0.5 * M_PI)
        let uiimage = UIImage(CGImage: image)
        UIGraphicsBeginImageContext(CGSizeMake(uiimage.size.height, uiimage.size.width))
        let ctx = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(ctx, -1, 1)
        CGContextTranslateCTM(ctx, -uiimage.size.height, uiimage.size.width)
        CGContextRotateCTM(ctx, angle)
        uiimage.drawAtPoint(CGPointMake(0, 0))
        let out = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        runStack(Stack.Preview, payload: [
            "image": out
        ])
        
        let outRect = CGRectMake(0, 0, out.size.width, out.size.height)
        
        if features.count > 0 {
            
            // Filter features to find the one with the largest size
            var focusedFeature: CIFeature?
            for feature in features {
                if focusedFeature == nil {
                    focusedFeature = feature
                    continue
                }
                if feature.bounds.size.width > focusedFeature?.bounds.size.width {
                    focusedFeature = feature
                }
            }
            
            // Apply normalization tranformation
            if let rect = focusedFeature?.bounds {
                var transform = CGAffineTransformMakeTranslation(0, videoRect.width)
                transform = CGAffineTransformScale(transform, -1, -1)
                transform = CGAffineTransformRotate(transform, -angle)
                let newRect = CGRectApplyAffineTransform(rect, transform)
                
                // Crop image
                let clone = CGImageCreateCopy(out.CGImage)
                let croppedImage = CGImageCreateWithImageInRect(clone, newRect)
                
                if croppedImage != nil {
                    let img = UIImage(CGImage: croppedImage!)
                    // Run detection stack
                    let payload: [String: Any] = [
                        "feature": newRect,
                        "videoRect": outRect,
                        "croppedImage": img,
                        "image": out,
                    ]
                    runStack(Stack.Detection, payload: payload)
                }
            }
        }
    }
    
    private func runStack(stack: Stack, payload: [String: Any]) {
        var handlers: [NBHandler]
        switch stack {
        case .Detection:
            handlers = detectionHandlers
            
        case .Preview:
            handlers = previewHandlers
        }
        
        for handler in handlers {
            handler.handle(payload)
        }
    }
    
    private func setupAVCapture() {
        var err: NSError? = nil
        
        session = AVCaptureSession()
        guard let session = session else {
            return
        }
        
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        let devices = AVCaptureDevice.devices()
        for d in devices {
            guard let d = d as? AVCaptureDevice else {
                continue
            }
            if d.hasMediaType(AVMediaTypeVideo) && d.position == .Front {
                device = d
            }
        }
        
        guard let device = device else {
            return
        }
        
        if device.focusPointOfInterestSupported {
            device.focusPointOfInterest = CGPointMake(
                UIScreen.mainScreen().bounds.size.width * 0.5,
                UIScreen.mainScreen().bounds.size.height * 0.5
            )
            device.focusMode = AVCaptureFocusMode.ContinuousAutoFocus
        }
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: device)
        } catch let error as NSError {
            err = error
            deviceInput = nil
        }
        if err != nil {
            NB.log("Error: \(err?.userInfo)")
            return
        }
        
        guard let deviceInput = deviceInput else {
            return
        }
        
        if session.canAddInput(deviceInput) {
            session.addInput(deviceInput)
        }
        
        videoDataOutput = AVCaptureVideoDataOutput()
        guard let videoDataOutput = videoDataOutput else {
            return
        }
        
        guard let rgbOutputSettings = NSDictionary(
                object: NSNumber(unsignedInt: kCMPixelFormat_32BGRA),
                forKey: kCVPixelBufferPixelFormatTypeKey as String
            ) as? [NSObject: AnyObject] else {
                return
        }
        videoDataOutput.videoSettings = rgbOutputSettings
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
        
        videoDataOutput.connectionWithMediaType(AVMediaTypeVideo).enabled = true
        
        start()
    }
    
    // MARK: Public API
    
    func addDetectionHandler(handler: NBHandler) {
        detectionHandlers.append(handler)
    }
    
    func addPreviewHandler(handler: NBHandler) {
        previewHandlers.append(handler)
    }
    
    func removeDetectionHandler(handler: NBHandler) -> Bool {
        if let index = detectionHandlers.indexOf(handler) {
            detectionHandlers.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func removePreviewHandler(handler: NBHandler) -> Bool {
        if let index = previewHandlers.indexOf(handler) {
            previewHandlers.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func start() {
        guard let session = session else {
            return
        }
        session.startRunning()
    }
    
    func stop() {
        guard let session = session else {
            return
        }
        session.stopRunning()
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate implementation
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        guard let detector = detector,
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let pixelBuffer = imageBuffer as CVPixelBufferRef
        let image = CIImage(CVPixelBuffer: pixelBuffer)
        let ctx = CIContext(options: nil)
        let ctxRect = CGRectMake(
            0, 0,
            CGFloat(CVPixelBufferGetWidth(pixelBuffer)),
            CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        )
        let ctxImage = ctx.createCGImage(image, fromRect: ctxRect)
        let imageOptions = [
            CIDetectorImageOrientation: NSNumber(integer: 8) // upside-down constant
        ]
        let features = detector.featuresInImage(image, options: imageOptions)
        guard let desc = CMSampleBufferGetFormatDescription(sampleBuffer) else {
            return
        }
        
        let cleanAperture: CGRect = CMVideoFormatDescriptionGetCleanAperture(desc, false)
        
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            self?.processFeatures(features , image: ctxImage, videoRect: cleanAperture)
        }
    }
}