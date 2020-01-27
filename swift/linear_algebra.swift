typealias Vector = [Float]
typealias Matrix = [[Float]]

let A = [[1, 2, 3],
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

