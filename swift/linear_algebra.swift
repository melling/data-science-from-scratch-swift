/*
 Data Science from Scratch
 Joel Grus
 Chapter 4: Linear Algebra
 Implemented in Swift 5.x
 
Python: https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/linear_algebra.py

 - Sticking with snake_case variable names for consistency
 
 */

import Foundation //sqrt

typealias Vector = [Float]
typealias Matrix = [[Float]]

// pg 56

func add(_ v: Vector, _ w: Vector) -> Vector {
    var result:Vector = []
    assert(v.count == w.count, "vectors must be the same length")
    for (v_i, w_i) in zip(v, w) {
        let x = v_i + w_i
        result.append(x)
    }
    return result
}

func subtract(_ v: Vector, _ w: Vector) -> Vector {
    var result:Vector = []
    assert(v.count == w.count, "vectors must be the same length")
    for (v_i, w_i) in zip(v, w) {
        let x = v_i - w_i
        result.append(x)
    }
    return result
}

assert(add([1, 2, 3], [4, 5, 6]) == [5, 7, 9])
assert(subtract([5, 7, 9], [4, 5, 6]) == [1, 2, 3])


func vector_sum(_ vectors: [Vector]) -> Vector {
    assert(vectors.count > 0, "no vectors provided")
    let vectorLength = vectors.first?.count ?? 0
    
    var result:Vector = Array(repeating: 0, count: vectorLength)
    //assert(v.count == w.count, "vectors must be the same length")
    for vec in vectors {
        for i in 0..<vectorLength {
            result[i] += vec[i]
        }
        
    }
    return result
}

assert(vector_sum([[1,2],[3,4],[5,6],[7,8]]) == [16,20])


func scalar_multiply(_ c:Float, _ v:Vector) -> Vector {
     v.map {$0 * c}
}


assert(scalar_multiply(2, [1, 2, 3]) == [2, 4, 6])

func vector_mean(_ vectors:[Vector]) -> Vector {
    let n:Float = Float(vectors.count)
    return scalar_multiply(Float(1/n), vector_sum(vectors))
}
vector_mean([[1,2], [3,4], [5,6]])

assert(vector_mean([[1,2], [3,4], [5,6]]) == [3,4])

// pg 58

func dot(_ v:Vector, _ w:Vector) -> Float {
    assert(v.count == w.count, "vectors must be the same length")
    var total:Float = 0
    for (v_i, w_i) in zip(v, w) {
        total += v_i * w_i
    }
    return total
}

assert(dot([1, 2, 3], [4, 5, 6]) == 32)

func sum_of_squares(_ v:Vector) -> Float {dot(v, v)}

assert(sum_of_squares([1, 2, 3]) == 14) // 1*1 + 2*2 + 3*3

func magnitude(_ v:Vector) -> Float {sqrt(sum_of_squares(v))}

assert(magnitude([3, 4]) == 5)

// pg 59

func squared_distance(_ v:Vector, _ w:Vector) -> Float {sum_of_squares(subtract(v, w))}

func distance(_ v:Vector, _ w:Vector) -> Float {magnitude(subtract(v, w))}



// pg 60



/*
 Data Science from Scratch
 Joel Grus
 Chapter 4: Linear Algebra
 Implemented in Swift 5.x
 
 Python: https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/linear_algebra.py
 
 - Sticking with snake_case variable names for consistency
 
 */

import Foundation //sqrt

public typealias Vector = [Float]
public typealias Matrix = [[Float]]

// pg 56

public func add(_ v: Vector, _ w: Vector) -> Vector {
    var result:Vector = []
    assert(v.count == w.count, "vectors must be the same length")
    for (v_i, w_i) in zip(v, w) {
        let x = v_i + w_i
        result.append(x)
    }
    return result
}

public func subtract(_ v: Vector, _ w: Vector) -> Vector {
    var result:Vector = []
    assert(v.count == w.count, "vectors must be the same length")
    for (v_i, w_i) in zip(v, w) {
        let x = v_i - w_i
        result.append(x)
    }
    return result
}

func test_add_subtract() {
    assert(add([1, 2, 3], [4, 5, 6]) == [5, 7, 9])
    assert(subtract([5, 7, 9], [4, 5, 6]) == [1, 2, 3])
}

let test0 = test_add_subtract()



public func vector_sum(_ vectors: [Vector]) -> Vector {
    assert(vectors.count > 0, "no vectors provided")
    let vectorLength = vectors.first?.count ?? 0
    
    var result:Vector = Array(repeating: 0, count: vectorLength)
    //assert(v.count == w.count, "vectors must be the same length")
    for vec in vectors {
        for i in 0..<vectorLength {
            result[i] += vec[i]
        }
        
    }
    return result
}


func test_vector_sum() {
    assert(vector_sum([[1,2],[3,4],[5,6],[7,8]]) == [16,20])
}

let test2 = test_vector_sum()


public func scalar_multiply(_ c:Float, _ v:Vector) -> Vector {
    v.map {$0 * c}
}

func test_scalar_multiply() {
    assert(scalar_multiply(2, [1, 2, 3]) == [2, 4, 6])
}

//

public func vector_mean(_ vectors:[Vector]) -> Vector {
    let n:Float = Float(vectors.count)
    return scalar_multiply(Float(1/n), vector_sum(vectors))
}

func test_vector_mean() {
    vector_mean([[1,2], [3,4], [5,6]])
    
    assert(vector_mean([[1,2], [3,4], [5,6]]) == [3,4])
}



// pg 58

public func dot(_ v:Vector, _ w:Vector) -> Float {
    assert(v.count == w.count, "vectors must be the same length")
    var total:Float = 0
    for (v_i, w_i) in zip(v, w) {
        total += v_i * w_i
    }
    return total
}
func test_dot() {
    assert(dot([1, 2, 3], [4, 5, 6]) == 32)
}

//

public func sum_of_squares(_ v:Vector) -> Float {dot(v, v)}

func test_sum_of_squares() {
    assert(sum_of_squares([1, 2, 3]) == 14) // 1*1 + 2*2 + 3*3
}

//

public func magnitude(_ v:Vector) -> Float {sqrt(sum_of_squares(v))}

func test_magnitude() {
    assert(magnitude([3, 4]) == 5)
}

//

// pg 59

public func squared_distance(_ v:Vector, _ w:Vector) -> Float {sum_of_squares(subtract(v, w))}

public func distance(_ v:Vector, _ w:Vector) -> Float {magnitude(subtract(v, w))}



// pg 60

let A:Matrix = [[1, 2, 3],
                [4, 5, 6]]


let B = [[1, 2],
         [3, 4],
         [5, 6]]

// p60

public func shape(A:Matrix) -> (Int, Int) {
    let num_rows = A.count
    let num_cols = A[0].count
    
    return (num_rows, num_cols)
}

// p60

public func get_row(A: Matrix, i: Int) -> Vector { A[i] }


public func get_column(A: Matrix, j: Int) -> Vector {
    var vec:Vector = []
    
    for A_i in A {
        let col_val = A_i[j]
        vec.append(col_val)
    }
    return vec
}

public func make_matrix(num_rows: Int,
                 num_cols: Int
    //entry_fn
) -> Matrix {
    var m:Matrix = [[]]
    
    return m
}

//  p61

public func identity_matrix(_ n:Int) -> Matrix {
    var m:Matrix = []
    for i in 0..<n  {
        var row:[Float] = []
        for j in 0..<n {
            let val:Float = i == j ? 1 : 0
            row.append(val)
        }
        m.append(row)
    }
    return m
}

func test_shape() {
    assert(shape(A: [[1, 2, 3], [4, 5, 6]]) == (2, 3))
}

//

let identity = identity_matrix(3)
