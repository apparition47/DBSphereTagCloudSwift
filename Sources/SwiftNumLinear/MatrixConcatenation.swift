//
//  MatrixConcatenation.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/1/17.
//
//


public protocol MatrixOrDouble { } // Don't use this for anything else!

extension Matrix: MatrixOrDouble { }
extension Double: MatrixOrDouble { }

// Matrix concatenation
public extension Matrix {
    static func horizontalConcatenate(_ items: [MatrixOrDouble]) -> Matrix {
        var width = 0
        var height = -1
        for i in items {
            if let m = i as? Matrix {
                width += m.width
                if height != 1 && height != -1 && m.height != height {
                    fatalError("Can not horizontally concatenate matrices of different heights")
                }
                height = m.height
            } else {
                width += 1
                if height < 1 {
                    height = 1
                }
            }
        }
        
        var resData = [Double](repeating: 0, count: width * height)
        for r in 0..<height {
            var c = 0
            for i in items {
                let base = r*width + c
                let itemWidth: Int
                if let m = i as? Matrix {
                    itemWidth = m.width
                    if height == 1 {
                        resData[base..<(base + itemWidth)] = m.data[0..<m.width]
                    } else {
                        resData[base..<(base + itemWidth)] = m.data[r*m.width..<((r + 1)*m.width)]
                    }
                } else {
                    let d = i as! Double
                    itemWidth = 1
                    resData[base] = d
                }
                
                c += itemWidth
            }
        }
        
        return Matrix(rowMajorData: resData, width: width)
    }
    
    static func verticalConcatenate(_ items: [MatrixOrDouble]) -> Matrix {
        var width = -1
        var height = 0
        for i in items {
            if let m = i as? Matrix {
                height += m.height
                if width != 1 && width != -1 && m.width != width {
                    fatalError("Can not vertically concatenate matrices of different width")
                }
                width = m.width
            } else {
                height += 1
                if width < 1 {
                    width = 1
                }
            }
        }
        
        var resData = [Double](repeating: 0, count: width * height)
        var idx = 0
        for i in items {
            let len: Int
            if let m = i as? Matrix {
                if m.width == 1 {
                    len = width * m.height
                    for r in 0..<m.height {
                        resData[(idx + r*width)..<(idx + (r+1)*width)] = [Double](repeating: m.data[r], count: width)[0..<width]
                    }
                } else {
                    len = m.width * m.height
                    resData[idx..<(idx+len)] = m.data[0..<m.data.count]
                }
            } else {
                let d = i as! Double
                len = width
                resData[idx..<(idx+len)] = [Double](repeating: d, count: width)[0..<width]
            }
            idx += len
        }
        
        return Matrix(rowMajorData: resData, width: width)
    }
    
    init(format: [[MatrixOrDouble]]) {
        let rows = format.map(Matrix.horizontalConcatenate)
        let m = Matrix.verticalConcatenate(rows)
        data = m.data
        width = m.width
        height = m.height
    }
}
