//
//  DBSphereView.h
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

import UIKit

class DBSphereView: UIView, UIGestureRecognizerDelegate {
    /**
     *  Sets the cloud's tag views.
     *
     *	@remarks Any @c UIView subview can be passed in the array.
     *
     *  @param array The array of tag views.
     */
    func setCloudTags(_ array: [Any]) {
        tags = [Any](arrayLiteral: array)
        coordinate = [Any]() /* capacity: 0 */
        for i in 0..<tags.count {
            var view = tags[i]
            (view as AnyObject).center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        }
        var p1: CGFloat = .pi * (3 - sqrt(5))
        var p2: CGFloat = 2.0 / tags.count
        for i in 0..<tags.count {
            var y: CGFloat = i * p2 - 1 + (p2 / 2)
            var r: CGFloat = sqrt(1 - y * y)
            var p3: CGFloat = i * p1
            var x: CGFloat = cos(p3) * r
            var z: CGFloat = sin(p3) * r
            var point = DBPointMake(x, y, z)
//            var value = NSValue(point, withObjCType: )
            coordinate.append(point)
            var time: CGFloat = (arc4random() % 10 + 10.0) / 20.0
            UIView.animate(withDuration: time, delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
                self.setTagOf(point, andIndex: i)
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
        var a = arc4random() % 10 - 5
        var b = arc4random() % 10 - 5
        normalDirection = DBPointMake(a, b, 0)
        self.timerStart()
    }
    /**
     *  Starts the cloud autorotation animation.
     */
    
    func timerStart() {
        timer = CADisplayLink.displayLink(withTarget: self, selector: #selector(self.autoTurnRotation))
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    /**
     *  Stops the cloud autorotation animation.
     */
    
    func timerStop() {
        timer.invalidate()
        timer = nil
    }
    var tags = [Any]()
    var coordinate = [Any]()
    var normalDirection = DBPoint()
    var last = CGPoint.zero
    var velocity: CGFloat = 0.0
    var timer: CADisplayLink!
    var inertia: CADisplayLink!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        self.addGestureRecognizer(gesture)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - initial set
    // MARK: - set frame of point
    
    func updateFrameOfPoint(_ index: Int, direction: DBPoint, andAngle angle: CGFloat) {
        var value = coordinate[index]
        var point: DBPoint
        (value as AnyObject).getValue(point)
        var rPoint = DBPointMakeRotation(point, direction, angle)
//        value = NSValue(rPoint, withObjCType: )
        coordinate[index] = rPoint
        self.setTagOf(rPoint, andIndex: index)
    }
    
    func setTagOf(_ point: DBPoint, andIndex index: Int) {
        var view = tags[index]
        (view as AnyObject).center = CGPoint(x: (point.x + 1) * (self.frame.size.width / 2.0), y: (point.y + 1) * self.frame.size.width / 2.0)
        var transform: CGFloat = (point.z + 2) / 3
        (view as AnyObject).transform = CGAffineTransform.identity.scaledBy(x: transform, y: transform)
        (view as AnyObject).layer.zPosition = transform
        (view as AnyObject).alpha = transform
        if point.z < 0 {
            (view as AnyObject).userInteractionEnabled = false
        }
        else {
            (view as AnyObject).userInteractionEnabled = true
        }
    }
    // MARK: - autoTurnRotation
    
    func autoTurnRotation() {
        for i in 0..<tags.count {
            self.updateFrameOfPoint(i, direction: normalDirection, andAngle: 0.002)
        }
    }
    // MARK: - inertia
    
    func inertiaStart() {
        self.timerStop()
        inertia = CADisplayLink.displayLink(withTarget: self, selector: #selector(self.inertiaStep))
        inertia.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func inertiaStop() {
        inertia.invalidate()
        inertia = nil
        self.timerStart()
    }
    
    func inertiaStep() {
        if velocity <= 0 {
            self.inertiaStop()
        }
        else {
            velocity -= 70.0
            var angle: CGFloat = velocity / self.frame.size.width * 2.0 * inertia.duration
            for i in 0..<tags.count {
                self.updateFrameOfPoint(i, direction: normalDirection, andAngle: angle)
            }
        }
    }
    // MARK: - gesture selector
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            last = gesture.location(in: self)
            self.timerStop()
            self.inertiaStop()
        }
        else if gesture.state == .changed {
            var current = gesture.location(in: self)
            var direction = DBPointMake(last.y - current.y, current.x - last.x, 0)
            var distance: CGFloat = sqrt(direction.x * direction.x + direction.y * direction.y)
            var angle: CGFloat = distance / (self.frame.size.width / 2.0)
            for i in 0..<tags.count {
                self.updateFrameOfPoint(i, direction: direction, andAngle: angle)
            }
            normalDirection = direction
            last = current
        }
        else if gesture.state == .ended {
            var velocityP = gesture.velocity(in: self)
            velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y)
            self.inertiaStart()
        }
        
    }
}
