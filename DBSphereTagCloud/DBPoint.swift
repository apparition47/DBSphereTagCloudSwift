//
//  DBPoint.swift
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

import Foundation

public struct DBPoint {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
}

public func DBPointMake(_ x: CGFloat, y: CGFloat, z: CGFloat) -> DBPoint {
    var point: DBPoint = DBPoint(x: x, y: y, z: z)
    return point
}
