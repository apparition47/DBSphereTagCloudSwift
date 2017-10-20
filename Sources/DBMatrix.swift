//
//  DBMatrix.swift
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

import UIKit

//func DBMatrixMake(_ column: Int, row: Int) -> DBMatrix {
//    var matrix: DBMatrix = DBMatrix(column: column, row: row, matrix: [[CGFloat]](repeating: [CGFloat](repeating: 0, count: 4), count: 4))
//    for i in 0..<column {
//        for j in 0..<row {
//            matrix.matrix[i][j] = 0
//        }
//    }
//    return matrix
//}

//func DBMatrixMakeFromArray(_ column: Int, row: Int, data: UnsafeMutablePointer<[CGFloat]>) -> DBMatrix {
//    var matrix = DBMatrixMake(column, row: row)
//    for i in 0..<column {
//        let t: CGFloat = data.pointee + CGFloat(i * row)
//        for j in 0..<row {
//            matrix.matrix[i][j] = t + CGFloat(j)
//        }
//    }
//    return matrix
//}

//func DBMatrixMutiply(_ a: DBMatrix, b: DBMatrix) -> DBMatrix {
//    var result = DBMatrixMake(a.column, row: b.row)
//    for i in 0..<a.column {
//        for j in 0..<b.row {
//            for k in 0..<a.row {
//                result.matrix[i][j] += a.matrix[i][k] * b.matrix[k][j]
//            }
//        }
//    }
//    return result
//}

func DBPointMakeRotation(point: DBPoint, direction: DBPoint, angle: CGFloat) -> DBPoint {
    if angle == 0 {
        return point
    }
    let temp2: [[Double]] = [[Double(point.x), Double(point.y), Double(point.z), 1], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
    //    DBMatrix pointM = DBMatrixMakeFromArray(1, 4, *temp2);
    
//    var result = DBMatrixMakeFromArray(1, row:4, data:&temp2)
    var result: Matrix = Matrix(temp2)
    if direction.z * direction.z + direction.y * direction.y != 0 {
        let cos1: Double = Double(direction.z / sqrt(direction.z * direction.z + direction.y * direction.y))
        let sin1: Double = Double(direction.y / sqrt(direction.z * direction.z + direction.y * direction.y))
        let t1 = [[1, 0, 0, 0], [0, cos1, sin1, 0], [0, -sin1, cos1, 0], [0, 0, 0, 1]]
//        let m1: DBMatrix = DBMatrixMakeFromArray(4, row:4, data:&t1)
//        result = DBMatrixMutiply(result, b:m1)
        result *= Matrix(t1)
    }
    
    if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
        let cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let t2 = [[Double(cos2), 0, Double(-sin2), 0], [0, 1, 0, 0], [Double(sin2), 0, Double(cos2), 0], [0, 0, 0, 1]]
//        let m2 = DBMatrixMakeFromArray(4, row:4, data:t2)
//        result = DBMatrixMutiply(result, b:m2)
        
        result *= Matrix(t2)
    }
    
    let cos3 = Double(cos(angle))
    let sin3 = Double(sin(angle))
    let t3 = [[cos3, sin3, 0, 0], [-sin3, cos3, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
//    let m3 = DBMatrixMakeFromArray(4, row:4, data:t3)
//    result = DBMatrixMutiply(result, b:m3)
    result *= Matrix(t3)
    
    if direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0 {
        let cos2: CGFloat = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let sin2: CGFloat = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z)
        let t2_ = [[Double(cos2), 0, Double(sin2), 0], [0, 1, 0, 0], [Double(-sin2), 0, Double(cos2), 0], [0, 0, 0, 1]]
//        let m2_ = DBMatrixMakeFromArray(4, row:4, data:t2_)
//        result = DBMatrixMutiply(result, b:m2_)
        result *= Matrix(t2_)
    }
    
    if direction.z * direction.z + direction.y * direction.y != 0 {
        let cos1: CGFloat = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y)
        let sin1: CGFloat = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y)
        let t1_ = [[1, 0, 0, 0], [0, Double(cos1), Double(-sin1), 0], [0, Double(sin1), Double(cos1), 0], [0, 0, 0, 1]]
//        let m1_ = DBMatrixMakeFromArray(4, row:4, data:t1_)
//        result = DBMatrixMutiply(result, b:m1_)
        result *= Matrix(t1_)
    }

//    let resultPoint = DBPointMake(result.matrix[0][0], y: result.matrix[0][1], z: result.matrix[0][2])
    let resultPoint = DBPoint(x: CGFloat(result[0,0]), y: CGFloat(result[0,1]), z: CGFloat(result[0,2]))
    
    return resultPoint
}
