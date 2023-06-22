//
//  MatrixPrint.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/4/17.
//
//

import Foundation

extension Matrix: CustomStringConvertible {
    public var description: String {
        var maxWidth = 0
        for r in 0..<height {
            for c in 0..<width {
                let num = String(format: "%.4g", self[r, c])
                maxWidth = max(maxWidth, num.count)
            }
        }
        
        
        var final = "\(height) x \(width) matrix:\n"
        for r in 0..<height {
            final += "    "
            for c in 0..<width {
                let num = String(format: "%.4g", self[r, c])
                final += num
                if c != width - 1 {
                    final += repeatElement(" ", count: maxWidth - num.count + 2).reduce("", +)
                }
            }
            
            final += "\n"
            
        }
        return final
    }
}

extension Matrix: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}
