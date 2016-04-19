/**********************************************
 *
 * Matrix.swift
 *
 * Matrix Operations in Swift
 * 
 * CIS 343 - Project 6
 * Professor Nandigam
 *
 * Authors: Morrie Cunningham & Devin Brown
 *
 ***********************************************/

import Cocoa

// Created our own errors
enum MatrixError : ErrorType {
    case InvalidRows
    case InvalidColumns
    case InvalidMultiply
}

// Creates the messages for our errors
extension MatrixError : CustomStringConvertible {
    var description: String {
        switch self {
        case .InvalidRows:
            return "Rows Don't Match!"
        case .InvalidColumns:
            return "Columns Don't Match!"
        case .InvalidMultiply:
            return "The number of columns of Matrix A doesnt equal the rows of Matrix B!"
        }
    }
}

// Main Matrix class
class Matrix: NSObject {
    
    var columns: Int = 0
    var rows: Int = 0
    var data: [Int] = []
    
    override var description: String {
        var string = ""
        
        for r in 0..<rows {
            for c in 0..<columns {
                string += "\(self.get(r, column: c)) "
            }
            string.removeAtIndex(string.endIndex.predecessor())
            string += "\n"
        }
        return string
    }
    
    convenience override init() {
        self.init(rows: 5, columns: 5, data: 0)
    }
    
    // Constructor function
    init(rows: Int, columns: Int, data: Int) {
        self.rows = rows
        self.columns = columns
        
        for r in 0..<rows {
            for c in 0..<columns {
                self.data.append(data)
            }
        }
    }
    
    // Getter method
    func get(row: Int, column: Int) -> Int {
        return self.data[(row*self.columns) + column]
    }
    
    // Setter method
    func set(row: Int, column: Int, val: Int) {
        self.data[(row*self.columns) + column] = val
    }
    
    // Adds two Matrices together
    func add(m: Matrix) throws -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        if self.rows != m.rows {
            throw MatrixError.InvalidRows
        }
        
        if self.columns != m.columns {
            throw MatrixError.InvalidRows
        }
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) + m.get(r, column: c) )
            }
        }
        
        return newM
    }
    
    // Subtracts two Matrices from one another
    func subtract(m: Matrix) throws -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        if self.rows != m.rows {
            throw MatrixError.InvalidRows
        }
        
        if self.columns != m.columns {
            throw MatrixError.InvalidRows
        }
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) - m.get(r, column: c) )
            }
        }
        
        return newM
    }
    
    // Multiplies a Matrix by an integer
    func scalarMult(m: Matrix, k: Int) -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) * k )
            }
        }
        
        return newM
    }
    
    // Multiplies two Matrices together
    func Multiply(m: Matrix) throws -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: m.columns, data: 0)
        
        if self.columns != m.rows {
            throw MatrixError.InvalidMultiply
        }
        
        for r in 0..<rows {
            for c2 in 0..<m.columns {
                for c1 in 0..<columns {
                    var result = newM.get(r, column: c2)
                    result += (self.get(r, column: c1) * m.get(c1, column: c2))
                    newM.set(r, column: c2, val: result )
                }
            }
        }
        
        return newM
    }
    
    // Transposes the given Matrix
    func Transpose(m: Matrix) -> Matrix{
        let newM = Matrix.init(rows: self.columns, columns: self.rows, data: 0)
        
        for c in 0..<columns {
            for r in 0..<rows {
                newM.set(c, column: r, val: self.get(r, column: c) )
            }
        }
        
        return newM
    }
    
    // Creates an Identity Matrix of a given size
    static func indentity(size: Int) -> Matrix {
        let newM = Matrix.init(rows: size, columns: size, data: 0)
        
        for r in 0..<size {
            for c in 0..<size {
                if r == c {
                    newM.set(r, column: c, val: 1 )
                }
            }
        }
        
        return newM
    }
    
    // Function to fill Matrix with a value
    func fill(val: Int) {
        self.data = [Int](count: self.data.count , repeatedValue: val)
    }
    
    // Clones a Matrix
    func clone() -> Matrix {
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        newM.data = self.data    // Swift array so this is deep copy
        
        return newM
    }
    
    // Function to print a Matrix
    func generate() -> AnyGenerator<Int> {
        // keep the index of the next cell value in the iteration
        var nextIndex = self.data.count-1
        
        // Construct a AnyGenerator<Int> instance, passing a closure that returns the 
        // next cell value in the iteration
        return AnyGenerator {
            if (nextIndex < 0) {
                return nil
            }
            nextIndex -= 1
            return self.data[nextIndex]
        }
    }
    
}

// Function to override the '+' operand to add Matrices
func +(m1: Matrix, m2: Matrix) throws -> Matrix {
    return try m1.add(m2)
}

// Function to override the '-' operand to subtract Matrices
func -(m1: Matrix, m2: Matrix) throws-> Matrix {
    return try m1.subtract(m2)
}

// Function to override the '*' operand to multiply Matrices
func *(m1: Matrix, m2: Matrix) throws -> Matrix {
    return try m1.Multiply(m2)
}

// Function to see if two Matrices are equal to each other
func ==(m1: Matrix, m2: Matrix) -> Bool {
    for r in 0..<m1.rows {
        for c in 0..<m1.columns {
            if m1.get(r, column: c) != m2.get(r, column: c) {
                return false
            }
        }
    }
    return true
}