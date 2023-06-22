//
//  MatrixMisc.swift
//  SwiftLearn
//
//  Created by Donald Pinckney on 1/6/17.
//
//

public extension Matrix {
    static func unrollToColumnVector(Xs: [Matrix]) -> (column: Matrix, sizes: [(height: Int, width: Int)]) {
        let data = Xs.map { $0.data }.reduce([], +)
        
        return (Matrix(rowMajorData: data, width: 1), Xs.map { ($0.height, $0.width) })
    }
    
    static func rollColumnVectorToMatrices(column: Matrix, sizes: [(height: Int, width: Int)]) -> [Matrix] {
        var matrices: [Matrix] = []
        
        var matIdx = 0
        for (height, width) in sizes {
            matrices.append(Matrix(rowMajorData: Array(column.data[matIdx..<(matIdx + width * height)]), width: width))
            
            matIdx += width * height
        }
        
        return matrices
    }
}
