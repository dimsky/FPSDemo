//
//  FPS.swift
//  FrameRateDemo
//
//  Created by dimsky on 16/8/28.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import Foundation
import UIKit


class FPS: NSObject {
    static let instance = FPS()
    class var shared: FPS {
        return instance
    }

    let hardwareFPS = 60.0
    var frameDuration = 1.0
    let fpsLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 20, width: 60, height: 20))
    var link: CADisplayLink!
    var count: NSTimeInterval = 0
    var lastTime: NSTimeInterval = 0
    var lastSecondOfFrameTimes: [NSTimeInterval] = []

    var beganPoint = CGPoint.zero
    var frameNumber = 0
    var added = false

    var enable: Bool = false {
        didSet {
            if !enable {
                link.invalidate()
            }
        }
    }

    override init() {
        super.init()
        for _ in 0..<Int(hardwareFPS) {
            lastSecondOfFrameTimes.append(0)
        }
        frameDuration = 1.0 / hardwareFPS
        link = CADisplayLink(target: self, selector: #selector(start(_:)))
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        fpsLabel.text = "60fps"

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(move(_:)))

        fpsLabel.userInteractionEnabled = true

        fpsLabel.addGestureRecognizer(gesture)
    }


    func start(link: CADisplayLink) {
        if enable {
            if let keyWindow = UIApplication.sharedApplication().keyWindow where added == false {
                keyWindow.addSubview(fpsLabel)
                added = true
            }
        }

        frameNumber += 1
        let index = frameNumber % Int(hardwareFPS)
        lastSecondOfFrameTimes[index] = link.timestamp

        var droppedFrameCount = 0
        let lastFrameTime = CACurrentMediaTime() - frameDuration
        for i in 0..<Int(hardwareFPS) {
            if (1.0 <= lastFrameTime - lastSecondOfFrameTimes[i]) {
                droppedFrameCount += 1
            }
        }
        let currentFPS = Int(hardwareFPS) - droppedFrameCount

        if droppedFrameCount <= 2 {
            fpsLabel.backgroundColor = UIColor.greenColor()
        } else if droppedFrameCount <= 5 {
            fpsLabel.backgroundColor = UIColor.orangeColor()
        } else if droppedFrameCount <= 10 {
            fpsLabel.backgroundColor = UIColor.redColor()
        }
        fpsLabel.text = "\(currentFPS) FPS"
    }

    func move(gesture: UIPanGestureRecognizer) {
        if gesture.state == .Began {
            beganPoint = gesture.locationInView(fpsLabel)
        } else if gesture.state == .Changed {
            let newPoint = gesture.locationInView(fpsLabel)

            let offSetX = newPoint.x - beganPoint.x
            let offSetY = newPoint.y - beganPoint.y
            fpsLabel.center = CGPoint(x: fpsLabel.center.x + offSetX, y: fpsLabel.center.y + offSetY)

        } else if gesture.state == .Ended {

        }
    }
}
