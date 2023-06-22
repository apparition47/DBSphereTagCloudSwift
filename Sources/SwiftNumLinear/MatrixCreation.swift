//
//  MatrixCreation.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

public extension Matrix {
    static func zeros(_ height: Int, _ width: Int) -> Matrix {
        return fill(height, width, value: 0)
    }
    
    static func I(_ n: Int) -> Matrix {
        var data = [Double](repeating: 0, count: n*n)
        for r in 0..<n {
            data[r*n + r] = 1
        }
        return Matrix(rowMajorData: data, width: n)
    }
    
    static func fill(_ height: Int, _ width: Int, value: Double) -> Matrix {
        return Matrix(rowMajorData: [Double](repeating: value, count: width*height), width: width)
    }
}
