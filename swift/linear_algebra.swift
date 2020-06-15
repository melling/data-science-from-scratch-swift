/*
 Data Science from Scratch
 Joel Grus
 Chapter 4: Linear Algebra
 Implemented in Swift 5.x
 
 Python: https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/linear_algebra.py
 
 - Sticking with snake_case variable names for consistency
 - Python float is more like Swift Double
 */

import Foundation //sqrt

public typealias Vector = [Double]
public typealias Matrix = [[Double]]

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

private func test_add_subtract() {
    assert(add([1, 2, 3], [4, 5, 6]) == [5, 7, 9])
    assert(subtract([5, 7, 9], [4, 5, 6]) == [1, 2, 3])
}

private let test0 = test_add_subtract()



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


private func test_vector_sum() {
    assert(vector_sum([[1,2],[3,4],[5,6],[7,8]]) == [16,20])
}

private let test_vsum = test_vector_sum()


public func scalar_multiply(_ c:Double, _ v:Vector) -> Vector {
    v.map {$0 * c}
}

private func test_scalar_multiply() {
    assert(scalar_multiply(2, [1, 2, 3]) == [2, 4, 6])
}

//

public func vector_mean(_ vectors:[Vector]) -> Vector {
    let n:Double = Double(vectors.count)
    return scalar_multiply(Double(1/n), vector_sum(vectors))
}

private func test_vector_mean() {
    vector_mean([[1,2], [3,4], [5,6]])
    
    assert(vector_mean([[1,2], [3,4], [5,6]]) == [3,4])
}



// pg 58

public func dot(_ v:Vector, _ w:Vector) -> Double {
    assert(v.count == w.count, "vectors must be the same length")
    var total:Double = 0
    for (v_i, w_i) in zip(v, w) {
        total += v_i * w_i
    }
    return total
}
private func test_dot() {
    assert(dot([1, 2, 3], [4, 5, 6]) == 32)
}

//

public func sum_of_squares(_ v:Vector) -> Double {dot(v, v)}

private func test_sum_of_squares() {
    assert(sum_of_squares([1, 2, 3]) == 14) // 1*1 + 2*2 + 3*3
}

//

public func magnitude(_ v:Vector) -> Double {sqrt(sum_of_squares(v))}

private func test_magnitude() {
    assert(magnitude([3, 4]) == 5)
}

//

// pg 59

public func squared_distance(_ v:Vector, _ w:Vector) -> Double {sum_of_squares(subtract(v, w))}

public func distance(_ v:Vector, _ w:Vector) -> Double {magnitude(subtract(v, w))}



// pg 60

private let A:Matrix = [[1, 2, 3],
                [4, 5, 6]]


private let B = [[1, 2],
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
        var row:[Double] = []
        for j in 0..<n {
            let val:Double = i == j ? 1 : 0
            row.append(val)
        }
        m.append(row)
    }
    return m
}

private func test_shape() {
    assert(shape(A: [[1, 2, 3], [4, 5, 6]]) == (2, 3))
}

//

private let identity = identity_matrix(3)

