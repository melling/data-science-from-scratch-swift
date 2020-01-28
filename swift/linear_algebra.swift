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

// pg 60

let A:Matrix = [[1, 2, 3],
         [4, 5, 6]]


let B = [[1, 2],
         [3, 4],
         [5, 6]]

// p60

func shape(A:Matrix) -> (Int, Int) {
    let num_rows = A.count
    let num_cols = A[0].count
    
    return (num_rows, num_cols)
}

// p60

func get_row(A: Matrix, i: Int) -> Vector {
    return A[i]
}



func get_column(A: Matrix, j: Int) -> Vector {
    var vec:Vector = []
    
    for A_i in A {
        let col_val = A_i[j]
        vec.append(col_val)
    }
    return vec
}

func make_matrix(num_rows: Int,
                 num_cols: Int
                 //entry_fn
                 ) -> Matrix {
    var m:Matrix = [[]]
    
    return m
}

//  p61

func identity_matrix(_ n:Int) -> Matrix {
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

assert(shape(A: [[1, 2, 3], [4, 5, 6]]) == (2, 3))

let identity = identity_matrix(3)

