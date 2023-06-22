//
//  MatrixComponentWiseFunction.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//

import Foundation
import Accelerate

public func extendToMatrix(_ f: @escaping (Double) -> Double) -> ((Matrix) -> Matrix) {
    return { mat in
        var res = mat
        res.data = res.data.map(f)
        return res
    }
}

public func exp(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.exp)
    return res
}

public func log(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.log)
    return res
}

public func sin(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.sin)
    return res
}

public func cos(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.cos)
    return res
}

public func tan(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.tan)
    return res
}

public func sinh(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.sinh)
    return res
}

public func cosh(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.cosh)
    return res
}

public func tanh(_ X: Matrix) -> Matrix {
    var res = X
    res.data = X.data.map(Foundation.tanh)
    return res
}

public func abs(_ X: Matrix) -> Matrix {
    var res = X
    vDSP_vabsD(X.data, 1, &res.data, 1, vDSP_Length(X.data.count))
    return res
}
