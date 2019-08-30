//
//  DBSphereView.swift
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

import UIKit

struct DBPoint {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
}

open class DBSphereView: UIView, UIGestureRecognizerDelegate {
    
    var tags = [UIView]()
    private var coordinate = [DBPoint]()
    var normalDirection: DBPoint = DBPoint(x: 0, y: 0, z: 0)
    private var last = CGPoint.zero
    
    var velocity: CGFloat = 0.0
    
    private var timer: CADisplayLink!
    private var inertia: CADisplayLink!
    
    // MARK: - initial set
    
    /**
     *  Sets the cloud's tag views.
     *
     *	@remarks Any @c UIView subview can be passed in the array.
     *
     *  @param array The array of tag views.
     */
    public func setCloudTags(_ array: [UIView]) {
        tags = array
        for i in 0..<tags.count {
            let view:UIView = tags[i]
            view.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        }
        let p1: CGFloat = .pi * (3 - sqrt(5))
        let p2: CGFloat = 2.0 / CGFloat(tags.count)
        for i in 0..<tags.count {
            let y: CGFloat = CGFloat(i) * p2 - 1 + (p2 / 2)
            let r: CGFloat = sqrt(1 - y * y)
            let p3: CGFloat = CGFloat(i) * p1
            let x: CGFloat = cos(p3) * r
            let z: CGFloat = sin(p3) * r
            
            let point = DBPoint(x: x, y: y, z: z)
            coordinate.append(point)
            
            let time: CGFloat = (CGFloat(arc4random() % 10) + 10.0) / 20.0
            UIView.animate(withDuration: TimeInterval(time), delay: 0.0, options: .curveEaseOut, animations: {() -> Void in
                self.setTagOf(point, andIndex: i)
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
        
        let a:NSInteger = NSInteger(arc4random() % 10) - 5
        let b:NSInteger = NSInteger(arc4random() % 10) - 5
        normalDirection = DBPoint(x: CGFloat(a), y: CGFloat(b), z: 0)
        self.timerStart()
    }
    
    /**
     *  Starts the cloud autorotation animation.
     */
    public func timerStart() {
        timer.isPaused = false
    }
    
    /**
     *  Stops the cloud autorotation animation.
     */
    public func timerStop() {
        timer.isPaused = true
    }

    private func setup() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        self.addGestureRecognizer(gesture)
        
        inertia = CADisplayLink(target: self, selector: #selector(inertiaStep))
        inertia.add(to: .main, forMode: RunLoop.Mode.default)
        
        timer  = CADisplayLink(target: self, selector: #selector(autoTurnRotation))
        timer.add(to: .main, forMode: RunLoop.Mode.default)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - set frame of point
    
    func updateFrameOfPoint(_ index: Int, direction: DBPoint, andAngle angle: CGFloat) {
        let point: DBPoint = coordinate[index]
        
        let rPoint = DBPointMakeRotation(point: point, direction: direction, angle: angle)
        coordinate[index] = rPoint
        
        self.setTagOf(rPoint, andIndex: index)
    }
    
    func setTagOf(_ point: DBPoint, andIndex index: Int) {
        let view: UIView = tags[index]
        view.center = CGPoint(x: (point.x + 1) * (self.frame.size.width / 2.0), y: (point.y + 1) * self.frame.size.width / 2.0)
        
        let transform: CGFloat = (point.z + 2) / 3
        view.transform = CGAffineTransform.identity.scaledBy(x: transform, y: transform)
        view.layer.zPosition = transform
        view.alpha = transform
        if point.z < 0 {
            view.isUserInteractionEnabled = false
        }
        else {
            view.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - autoTurnRotation
    
    @objc func autoTurnRotation() {
        for i in 0..<tags.count {
            self.updateFrameOfPoint(i, direction: normalDirection, andAngle: 0.002)
        }
    }
    
    // MARK: - inertia
    
    func inertiaStart() {
        timerStop()
        inertia.isPaused = false
    }
    
    func inertiaStop() {
        timerStart()
        inertia.isPaused = true
    }
    
    @objc func inertiaStep() {
        if velocity <= 0 {
            self.inertiaStop()
        }
        else {
            velocity -= 70.0
            let angle: CGFloat = velocity / self.frame.size.width * 2.0 * CGFloat(inertia.duration)
            for i in 0..<tags.count {
                self.updateFrameOfPoint(i, direction: normalDirection, andAngle: angle)
            }
        }
    }
    
    // MARK: - gesture selector
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            last = gesture.location(in: self)
            self.timerStop()
            self.inertiaStop()
        }
        else if gesture.state == .changed {
            let current = gesture.location(in: self)
            let direction = DBPoint(x: last.y - current.y, y: current.x - last.x, z: 0)
            let distance: CGFloat = sqrt(direction.x * direction.x + direction.y * direction.y)
            let angle: CGFloat = distance / (self.frame.size.width / 2.0)
            for i in 0..<tags.count {
                self.updateFrameOfPoint(i, direction: direction, andAngle: angle)
            }
            normalDirection = direction
            last = current
        }
        else if gesture.state == .ended {
            let velocityP = gesture.velocity(in: self)
            velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y)
            self.inertiaStart()
        }
        
    }
}

extension DBSphereView {
    fileprivate func DBPointMakeRotation(point: DBPoint, direction: DBPoint, angle: CGFloat) -> DBPoint {
        if angle == 0 {
            return point
        }
        
        let temp2: [[Double]] = [[Double(point.x), Double(point.y), Double(point.z), 1], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
        
        var result: Matrix = Matrix(temp2)
        if direction.z * direction.z + direction.y * direction.y != 0 {
            let cos1: Double = Double(direction.z / sqrt(direction.z * direction.z + direction.y * direction.y))
            let sin1: Double = Double(direction.y / sqrt(direction.z * direction.z + direction.y * direction.y))
            let t1 = [[1, 0, 0, 0], [0, cos1, sin1, 0], [0, -sin1, cos1, 0], [0, 0, 0, 1]]
            result *= Matrix(t1)
        }
        
        if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
            let cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
            let sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
            let t2 = [[Double(cos2), 0, Double(-sin2), 0], [0, 1, 0, 0], [Double(sin2), 0, Double(cos2), 0], [0, 0, 0, 1]]
            
            result *= Matrix(t2)
        }
        
        let cos3 = Double(cos(angle))
        let sin3 = Double(sin(angle))
        let t3 = [[cos3, sin3, 0, 0], [-sin3, cos3, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
        result *= Matrix(t3)
        
        if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
            let cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
            let sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
            let t2_ = [[Double(cos2), 0, Double(sin2), 0], [0, 1, 0, 0], [Double(-sin2), 0, Double(cos2), 0], [0, 0, 0, 1]]
            
            result *= Matrix(t2_)
        }
        
        if direction.z * direction.z + direction.y * direction.y != 0 {
            let cos1: CGFloat = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y)
            let sin1: CGFloat = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y)
            let t1_ = [[1, 0, 0, 0], [0, Double(cos1), Double(-sin1), 0], [0, Double(sin1), Double(cos1), 0], [0, 0, 0, 1]]
            
            result *= Matrix(t1_)
        }
        
        let resultPoint = DBPoint(x: CGFloat(result[0,0]), y: CGFloat(result[0,1]), z: CGFloat(result[0,2]))
        
        return resultPoint
    }

}
