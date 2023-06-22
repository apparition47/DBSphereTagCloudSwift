//
//  MatrixRandom.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 12/27/16.
//
//

import Foundation

public extension Matrix {
    static func random(_ height: Int, _ width: Int) -> Matrix {
        var data = [Double](repeating: 0, count: width * height)
        for i in 0..<data.count {
            data[i] = Double(arc4random()) / Double(UInt32.max)
        }
        
        return Matrix(rowMajorData: data, width: width)
    }
}
