//: Playground - noun: a place where people can play

import Cocoa

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
    
    init(rows: Int, columns: Int, data: Int) {
        self.rows = rows
        self.columns = columns
        
        for r in 0..<rows {
            for c in 0..<columns {
                self.data.append(data)
            }
        }
    }
    
    func get(row: Int, column: Int) -> Int {
        return self.data[(row*self.columns) + column]
    }
    
    func set(row: Int, column: Int, val: Int) {
        self.data[(row*self.columns) + column] = val
    }
    
    func add(m: Matrix) -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) + m.get(r, column: c) )
            }
        }
        
        return newM
    }
    
    func subtract(m: Matrix) -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) - m.get(r, column: c) )
            }
        }
        
        return newM
    }
    
    func scalarMult(m: Matrix, k: Int) -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        
        for r in 0..<rows {
            for c in 0..<columns {
                newM.set(r, column: c, val: self.get(r, column: c) * k )
            }
        }
        
        return newM
    }
    
    func Multiply(m: Matrix) -> Matrix{
        let newM = Matrix.init(rows: self.rows, columns: m.columns, data: 0)
        
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

    func Transpose(m: Matrix) -> Matrix{
        let newM = Matrix.init(rows: self.columns, columns: self.rows, data: 0)
        
        for c in 0..<columns {
            for r in 0..<rows {
                newM.set(c, column: r, val: self.get(r, column: c) )
            }
        }
        
        return newM
    }
    
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
    
    func fill(val: Int) {
        self.data = [Int](count: self.data.count , repeatedValue: val)
    }
    
    func clone() -> Matrix {
        let newM = Matrix.init(rows: self.rows, columns: self.columns, data: 0)
        newM.data = self.data    // Swift array so this is deep copy
        
        return newM
    }
    
    func generate() -> AnyGenerator<Int> {
        // keep the index of the next car in the iteration
        var nextIndex = self.data.count-1
        
        // Construct a AnyGenerator<Car> instance, passing a closure that returns the next car in the iteration
        return AnyGenerator {
            if (nextIndex < 0) {
                return nil
            }
            nextIndex -= 1
            return self.data[nextIndex]
        }
    }
    
}


func +(m1: Matrix, m2: Matrix) -> Matrix {
    return m1.add(m2)
}

func -(m1: Matrix, m2: Matrix) -> Matrix {
    return m1.subtract(m2)
}

func *(m1: Matrix, m2: Matrix) -> Matrix {
    return m1.Multiply(m2)
}

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





