//
//  main.swift
//  CIS343MatrixOperations
//
//  Created by Morrie Cunningham on 4/9/16.
//  Copyright © 2016 Morrie Cunningham. All rights reserved.
//

import Foundation

var m1 = Matrix.init(rows: 3, columns: 4, data: 4)
var m2 = Matrix.init(rows: 3, columns: 4, data: 2)
var m3 = Matrix.init(rows: 4, columns: 5, data: 3)
var m4 = Matrix.init(rows: 3, columns: 5, data: 40)
var m5 = Matrix.init(rows: 3, columns: 5, data: 40)


print(m1)
print(m3)
print(m1 * m3)
print(m3)
print(m4)
print(m1.add(m3))
print(m1.subtract(m2))
print(m1.scalarMult(m1, k: 7))
print(m4.Transpose(m4))
print(Matrix.indentity(7))
print("Is Matrix 1 equal to Matrix 2?? \(m1 == m2)")
print("Is Matrix 4 equal to Matrix 5?? \(m4 == m5)")


