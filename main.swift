/**********************************************
 *
 * main.swift
 *
 * Main Method for Matrix Operations in Swift
 *
 * CIS 343 - Project 6
 * Professor Nandigam
 *
 * Authors: Morrie Cunningham & Devin Brown
 *
 ***********************************************/

import Foundation

// Creating some matrices to test with
var m1 = Matrix.init(rows: 3, columns: 4, data: 4)
var m2 = Matrix.init(rows: 3, columns: 4, data: 2)
var m3 = Matrix.init(rows: 4, columns: 5, data: 3)
var m4 = Matrix.init(rows: 3, columns: 5, data: 40)
var m5 = Matrix.init(rows: 3, columns: 5, data: 40)

// Tests printing the matrices
print(m1)
print(m2)
print(m3)
print(m4)

// Tests the error of when multiplying 2 invalid matrices together
do {
    try print(m1 * m2)
} catch MatrixError.InvalidMultiply {
    print("Error: \(MatrixError.InvalidMultiply.description)\n")
}

// Tests the error of when adding 2 invalid matrices together
do {
    try print(m1.add(m3))
    
} catch MatrixError.InvalidRows {
    print("Error: \(MatrixError.InvalidRows.description)\n")
} catch MatrixError.InvalidColumns {
    print("Error: \(MatrixError.InvalidColumns.description)\n")
}

// Tests the error of when subtracting 2 invalid matrices together
do {
    try print(m1.subtract(m2))
} catch MatrixError.InvalidRows {
    print("Error: \(MatrixError.InvalidRows.description)")
} catch MatrixError.InvalidColumns {
    print("Error: \(MatrixError.InvalidColumns.description)")
}

// Tests the scalar multiply by a matrix function
print(m1.scalarMult(m1, k: 7))

// Tests the transposing function
print(m4.Transpose(m4))

// Tests the identity matrix function
print(Matrix.indentity(7))

// Tests the comparable function if 2 matrices are equal to each other
print("Is Matrix 1 equal to Matrix 2?? \(m1 == m2)")
print("Is Matrix 4 equal to Matrix 5?? \(m4 == m5)")


