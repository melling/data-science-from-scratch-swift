
/*
 Chapter 8: Gradient Descent
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/gradient_descent.py
 
 */

import Foundation //sqrt

/*
 ## Linear Algebra imports:
 - add()
 - distance()
 - dot()
 - scalar_multiply()
 - vector_mean()
 
 ### Indirect
 - subtract()
 - sum_of_squares()
 - magnitude()
 - vector_sum()
 
 */
typealias Vector = [Float]

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

func dot(_ v:Vector, _ w:Vector) -> Float {
    assert(v.count == w.count, "vectors must be the same length")
    var total:Float = 0
    for (v_i, w_i) in zip(v, w) {
        total += v_i * w_i
    }
    return total
}

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


func scalar_multiply(_ c:Float, _ v:Vector) -> Vector {v.map {$0 * c}}

func vector_mean(_ vectors:[Vector]) -> Vector {
    let n:Float = Float(vectors.count)
    return scalar_multiply(Float(1/n), vector_sum(vectors))
}

func sum_of_squares(_ v:Vector) -> Float {dot(v, v)}
func magnitude(_ v:Vector) -> Float {sqrt(sum_of_squares(v))}
func distance(_ v:Vector, _ w:Vector) -> Float {magnitude(subtract(v, w))}

/*
 
 Chapter 8
 */

// p101

func sum_of_squares(v:Vector) -> Float {
    dot(v, v)
}

sum_of_squares(v: [2,2])

func difference_quotient(f:(Float) -> Float, x:Float, h:Float) -> Float {
    let r = (f(x + h) - f(x)) / h
    return r
}


func square(_ x:Float) -> Float { x * x }

func derivative(_ x:Float) -> Float { 2 * x }

func test1() {
    let xs = (-10..<11)
    let actuals = xs.map {derivative(Float($0))}
    let estimates = xs.map {difference_quotient(f: square(_:), x:Float($0), h: 0.001)}
}

test1()

// p104

func partial_difference_quotient(f:(Vector) -> Float,
                                 v:Vector,
                                 i:Int,
                                 h:Float) -> Float {
    //let r = (f(x + h) - f(x)) / h
    var w:Vector = []
    
    for (j, v_j) in v.enumerated() {
        let a:Float
        if j == i {
            a = v_j + h
        } else {
            a = v_j
        }
        w.append(a)
    }
    let partial = (f(w) - f(v)) / h
    return partial
}

// p105

func estimate_gradient(f:(Vector) -> Float,
                       v:Vector,
                       h:Float = 0.0001) -> Vector {
    var vec:Vector = []
    
    for i in 0 ..< v.count {
        let p = partial_difference_quotient(f: f, v: v, i: i, h: h)
        vec.append(p)
    }
    return vec
}

func gradient_step(v:Vector, gradient:Vector, step_size:Float) -> Vector {
    assert(v.count == gradient.count)
    let step = scalar_multiply(step_size, gradient)
    return add(v, step)
}

func sum_of_squares_gradient(_ v:Vector) -> Vector {
    v.map {2 * $0}
}

func use_gradient() {
    var v:Vector = (0..<3).map {_ in Float.random(in: -10...10)}
    
    for epoch in 0 ..< 1000 {
        let grad = sum_of_squares_gradient(v)
        v = gradient_step(v: v, gradient: grad, step_size: -0.01)
        print("\(epoch), \(v)")
    }
    let dist = distance(v, [0, 0, 0])
    print("\(dist)")
    assert(distance(v, [0, 0, 0]) < 0.001)
}

//use_gradient()

func linear_gradient(x:Float, y:Float, theta:Vector) -> Vector {
    let slope = theta[0]
    let intercept = theta[1]
    
    let predicted = slope * x + intercept
    let error = predicted - y
    let squared_error = pow(error, 2)
    let grad = [2 * error * x, 2 * error]
    return grad
}

/*
 
 p107
 */
func use_gradient2(learning_rate:Float = 0.001) {
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    var theta:Vector = [Float.random(in: -1...1), Float.random(in: -1...1)]
    //let learning_rate:Float = 0.001
    
    for epoch in 0..<5000 {
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Float(x), y: Float(y), theta: theta)
            let grad = vector_mean([lgrads])
            theta = gradient_step(v: theta, gradient: grad, step_size: -learning_rate)
            print("\(epoch), \(theta)")
        }
        
    }
    let slope = theta[0]
    let intercept = theta[1]
    print("\(slope), \(intercept)")
    assert(slope > 19.9 && slope < 20.1)
    assert(intercept > 4.9 && intercept < 5.1)
}

//use_gradient2()

/*
 Minibatch and Stochastic Descent
 p108
 */
func minibatches<T>(dataset:[T], batch_size:Int, shuffle:Bool = true) -> [T] {
    var batch_starts = [0, 10]
    
    for start in batch_starts {
        
    }
    
    return dataset
}

func test_minibatch(learning_rate:Float = 0.001) {
    var theta:Vector = [Float.random(in: -1...1), Float.random(in: -1...1)]
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    
    for epoch in 0..<1000 {
        let batches = minibatches(dataset: inputs, batch_size: 20)
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Float(x), y: Float(y), theta: theta)
            let grad = vector_mean([lgrads])
            theta = gradient_step(v: theta, gradient: grad, step_size: -learning_rate)
            print("\(epoch), \(theta)")
        }
    }
}

// p109

func test_stochastic_gradient_descent(learning_rate:Float = 0.001) {
    var theta:Vector = [Float.random(in: -1...1), Float.random(in: -1...1)]
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    
    for epoch in 0..<100 {
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Float(x), y: Float(y), theta: theta)
            let grad = vector_mean([lgrads])
            theta = gradient_step(v: theta, gradient: grad, step_size: -learning_rate)
            print("\(epoch), \(theta)")
        }
    }
}


