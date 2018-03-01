//
//  FPS.swift
//  FrameRateDemo
//
//  Created by dimsky on 16/8/28.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import Foundation
import UIKit


public class XFPS: NSObject {
    public static let instance = XFPS()
    public class var shared: XFPS {
        return instance
    }

    let hardwareFPS = 60.0
    var frameDuration = 1.0
    let fpsLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 20, width: 60, height: 20))
    var link: CADisplayLink!
    var count: TimeInterval = 0
    var lastTime: TimeInterval = 0
    var lastSecondOfFrameTimes: [TimeInterval] = []

    var beganPoint = CGPoint.zero
    var frameNumber = 0
    var added = false

    public var enable: Bool = false {
        didSet {
            if !enable {
                link.invalidate()
                fpsLabel.removeFromSuperview()
            }
        }
    }

    public override init() {
        super.init()
        for _ in 0..<Int(hardwareFPS) {
            lastSecondOfFrameTimes.append(0)
        }
        frameDuration = 1.0 / hardwareFPS
        link = CADisplayLink(target: self, selector: #selector(start(link:)))
        link.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        fpsLabel.text = "60fps"

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(move(gesture:)))

        fpsLabel.isUserInteractionEnabled = true

        fpsLabel.addGestureRecognizer(gesture)
    }


    @objc public func start(link: CADisplayLink) {
        if enable {
            if let keyWindow = UIApplication.shared.keyWindow, added == false {
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
            fpsLabel.backgroundColor = UIColor.green
        } else if droppedFrameCount <= 5 {
            fpsLabel.backgroundColor = UIColor.orange
        } else if droppedFrameCount <= 10 {
            fpsLabel.backgroundColor = UIColor.red
        }
        fpsLabel.text = "\(currentFPS) FPS"
    }

    @objc public func move(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            beganPoint = gesture.location(in: fpsLabel)
        } else if gesture.state == .changed {
            let newPoint = gesture.location(in: fpsLabel)

            let offSetX = newPoint.x - beganPoint.x
            let offSetY = newPoint.y - beganPoint.y
            fpsLabel.center = CGPoint(x: fpsLabel.center.x + offSetX, y: fpsLabel.center.y + offSetY)

        } else if gesture.state == .ended {

        }
    }
}
