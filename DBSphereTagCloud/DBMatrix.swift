//
//  DBMatrix.h
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

import Foundation

public struct DBMatrix {
    var column: NSInteger
    var row: NSInteger
    var matrix: [[CGFloat]]
}

func DBMatrixMake(_ column: Int, row: Int) -> DBMatrix {
    var matrix: DBMatrix
    matrix.column = column
    matrix.row = row
    for i in 0..<column {
        for j in 0..<row {
            matrix.matrix[i][j] = 0
        }
    }
    return matrix
}

func DBMatrixMakeFromArray(_ column: Int, row: Int, data: [[CGFloat]]) -> DBMatrix {
    var matrix = DBMatrixMake(column, row: row)
    for i in 0..<column {
        var t: CGFloat = data + CGFloat(i * row)
        for j in 0..<row {
            matrix.matrix[i][j] = t + CGFloat(j)
        }
    }
    return matrix
}

func DBMatrixMutiply(_ a: DBMatrix, b: DBMatrix) -> DBMatrix {
    var result = DBMatrixMake(a.column, row: b.row)
    for i in 0..<a.column {
        for j in 0..<b.row {
            for k in 0..<a.row {
                result.matrix[i][j] += a.matrix[i][k] * b.matrix[k][j]
            }
        }
    }
    return result
}

func DBPointMakeRotation(_ point: DBPoint, direction: DBPoint, angle: CGFloat) -> DBPoint {
    //    CGFloat temp1[4] = {direction.x, direction.y, direction.z, 1};
    //    DBMatrix directionM = DBMatrixMakeFromArray(1, 4, temp1);
    if angle == 0 {
        return point
    }
    var temp2 = [point.x, point.y, point.z, 1]
    //    DBMatrix pointM = DBMatrixMakeFromArray(1, 4, *temp2);
    
    var result = DBMatrixMakeFromArray(1, row:4, data:temp2)
    if direction.z * direction.z + direction.y * direction.y != 0 {
        var cos1: CGFloat = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y)
        var sin1: CGFloat = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y)
        var t1 = [[1, 0, 0, 0], [0, cos1, sin1, 0], [0, -sin1, cos1, 0], [0, 0, 0, 1]]
        var m1 = DBMatrixMakeFromArray(4, row:4, data:t1)
        result = DBMatrixMutiply(a:result, b:m1)
    }
    
    if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
        var cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        var sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        var t2 = [[cos2, 0, -sin2, 0], [0, 1, 0, 0], [sin2, 0, cos2, 0], [0, 0, 0, 1]]
        var m2 = DBMatrixMakeFromArray(4, row:4, data:t2)
        result = DBMatrixMutiply(a:result, b:m2)
    }
    
    var cos3: CGFloat = cos(angle)
    var sin3: CGFloat = sin(angle)
    var t3 = [[cos3, sin3, 0, 0], [-sin3, cos3, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
    var m3 = DBMatrixMakeFromArray(4, 4, t3)
    result = DBMatrixMutiply(result, m3)
    
    if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
        var cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        var sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        var t2_ = [[cos2, 0, sin2, 0], [0, 1, 0, 0], [-sin2, 0, cos2, 0], [0, 0, 0, 1]]
        var m2_ = DBMatrixMakeFromArray(4, row:4, data:t2_)
        result = DBMatrixMutiply(a:result, b:m2_)
    }
    
    if direction.z * direction.z + direction.y * direction.y != 0 {
        var cos1: CGFloat = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y)
        var sin1: CGFloat = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y)
        var t1_ = [[1, 0, 0, 0], [0, cos1, -sin1, 0], [0, sin1, cos1, 0], [0, 0, 0, 1]]
        var m1_ = DBMatrixMakeFromArray(4, row:4, data:t1_)
        result = DBMatrixMutiply(a:result, b:m1_)
    }
    
    var resultPoint = DBPointMake(result.matrix[0][0], result.matrix[0][1], result.matrix[0][2])
    
    return resultPoint
}
