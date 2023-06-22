//
//  MatrixMultiplication.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

import Accelerate

public extension Matrix {
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.width == rhs.height)
        
        var res = Matrix.zeros(lhs.height, rhs.width)
        
        vDSP_mmulD(lhs.data, 1, rhs.data, 1, &res.data, 1, vDSP_Length(lhs.height), vDSP_Length(rhs.width), vDSP_Length(lhs.width))
        
        return res
    }
    static func *=(lhs: inout Matrix, rhs: Matrix) {
        lhs = lhs * rhs
    }
    
    
    static func *(lhs: Matrix, rhs: Double) -> Matrix {
        var res = lhs
        var rhs = rhs
        vDSP_vsmulD(res.data, 1, &rhs, &res.data, 1, vDSP_Length(lhs.data.count))
        return res
    }
    static func *(lhs: Double, rhs: Matrix) -> Matrix {
        return rhs * lhs
    }
    static func *=(lhs: inout Matrix, rhs: Double) {
        var rhs = rhs
        vDSP_vsmulD(lhs.data, 1, &rhs, &lhs.data, 1, vDSP_Length(lhs.data.count))
    }
}

infix operator .*: MultiplicationPrecedence
infix operator .*=: AssignmentPrecedence

public extension Matrix {
    static func .*(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.width == rhs.width)
        precondition(lhs.height == rhs.height)
        
        var res = rhs
        vDSP_vmulD(lhs.data, 1, rhs.data, 1, &res.data, 1, vDSP_Length(lhs.data.count))
        return res
    }
    
    static func .*=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.width == rhs.width)
        precondition(lhs.height == rhs.height)
        
        vDSP_vmulD(lhs.data, 1, rhs.data, 1, &lhs.data, 1, vDSP_Length(lhs.data.count))
    }
}
