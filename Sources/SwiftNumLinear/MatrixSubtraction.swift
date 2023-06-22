//
//  MatrixSubtraction.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

import Accelerate

public extension Matrix {
    static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.width == rhs.width)
        precondition(lhs.height == rhs.height)
        
        var res = lhs
        
        vDSP_vsubD(rhs.data, 1, lhs.data, 1, &res.data, 1, vDSP_Length(lhs.width * lhs.height))
        
        return res
    }
    static func -=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.width == rhs.width)
        precondition(lhs.height == rhs.height)
        
        vDSP_vsubD(rhs.data, 1, lhs.data, 1, &lhs.data, 1, vDSP_Length(lhs.width * lhs.height))
    }
    
    
    static func -(lhs: Matrix, rhs: Double) -> Matrix {
        var res = lhs
        var rhs = -rhs
        vDSP_vsaddD(res.data, 1, &rhs, &res.data, 1, vDSP_Length(lhs.data.count))
        return res
    }
    
    static func -=(lhs: inout Matrix, rhs: Double) {
        var rhs = -rhs
        vDSP_vsaddD(lhs.data, 1, &rhs, &lhs.data, 1, vDSP_Length(lhs.data.count))
    }
    
    static prefix func -(rhs: Matrix) -> Matrix {
        return -1 * rhs
    }
    
    static func -(lhs: Double, rhs: Matrix) -> Matrix {
        return lhs + (-rhs)
    }
}
