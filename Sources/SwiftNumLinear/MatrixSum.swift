//
//  MatrixSum.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/4/17.
//
//

import Accelerate

public extension Matrix {
    // Computes a vector sum of the columns of the matrix.
    func sumColumns() -> Matrix {
        var sum = self[0..<height, 0]
        
        for c in 1..<self.width {
            let col = self[0..<height, c]
            vDSP_vaddD(sum.data, 1, col.data, 1, &sum.data, 1, vDSP_Length(height))
        }
        return sum
    }
    
    // Computes a vector sum of the rows of the matrix.
    func sumRows() -> Matrix {
        var sum = self[0, 0..<width]
        
        for r in 1..<self.height {
            let row = self[r, 0..<width]
            vDSP_vaddD(sum.data, 1, row.data, 1, &sum.data, 1, vDSP_Length(width))
        }
        return sum
    }
    
    func sumAll() -> Double {
        var sum = 0.0
        vDSP_sveD(data, 1, &sum, vDSP_Length(width * height))
        return sum
    }
}
