//
//  MatrixRowsAndColumns.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/4/17.
//
//

public extension Matrix {
    // Returns an array of row vectors
    var rows: [Matrix] {
        return (0..<height).map { self[$0, 0..<width] }
    }
    
    // Return an array of column vectors
    var columns: [Matrix] {
        return (0..<width).map { self[0..<height, $0] }
    }
}
