//
//  MatrixTransposition.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

import Accelerate

public extension Matrix {
    var T: Matrix {
        var res = Matrix.zeros(width, height)
        vDSP_mtransD(data, 1, &res.data, 1, vDSP_Length(width), vDSP_Length(height))
        return res
    }
}
