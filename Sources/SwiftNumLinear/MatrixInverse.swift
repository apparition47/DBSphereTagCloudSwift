//
//  MatrixInverse.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

import Accelerate

public extension Matrix {
    var inverse: Matrix? {
        if width != height {
            return nil
        }
        
        var m = __CLPK_integer(width)
        var n = m
        var lda = m
        var error: __CLPK_integer = 0
        
        var mat = self.data
        var pivot = [__CLPK_integer](repeating: 0, count: Int(m))
        var workspace = [Double](repeating: 0, count: Int(m))
        
        dgetrf_(&m, &n, &mat, &lda, &pivot, &error)
        
        var res: Matrix? = nil
        if error == 0 {
            var w = __CLPK_integer(width)
            dgetri_(&n, &mat, &lda, &pivot, &workspace, &w, &error)
            res = Matrix(rowMajorData: mat, width: Int(__CLPK_integer(width)))
        }
        
        return res
    }
}

