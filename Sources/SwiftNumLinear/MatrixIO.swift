//
//  MatrixIO.swift
//  SwiftNum
//
//  Created by Donald Pinckney on 1/6/17.
//
//

import Foundation

public extension Matrix {
    init(csv: String) {
        let rowLines = csv.components(separatedBy: .newlines)
        var width = -1
        let rows = rowLines.compactMap { rowStr -> [Double]? in
            if rowStr == "" {
                return nil
            }
            
            let nums = rowStr.components(separatedBy: ",").map { numStr in
                Double(numStr.trimmingCharacters(in: .whitespaces))!
            }
            
            if width == -1 {
                width = nums.count
            }
            
            precondition(width == nums.count)
            
            return nums
        }
        
        let data = rows.reduce([], +)
        self.init(rowMajorData: data, width: width)
    }
    
    init(csvFileName: String) {
        let csv = try? String(contentsOfFile: csvFileName)
        
        if let csv = csv {
            self.init(csv: csv)
        } else {
            fatalError("File not found: \(csvFileName)")
        }
    }
    
    init(csvURL: URL) {
        let csv = try? String(contentsOf: csvURL)
        
        if let csv = csv {
            self.init(csv: csv)
        } else {
            fatalError("URL not read: \(csvURL)")
        }
    }
}
