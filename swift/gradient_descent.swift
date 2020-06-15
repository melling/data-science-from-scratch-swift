

/*
 Chapter 8: Gradient Descent
 
 Python: https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/gradient_descent.py
 
 */

import Foundation //sqrt


// p101

func sum_of_squares(v:Vector) -> Double {
    dot(v, v)
}

//sum_of_squares(v: [2,2])

func difference_quotient(f:(Double) -> Double, x:Double, h:Double) -> Double {
    let r = (f(x + h) - f(x)) / h
    return r
}


func square(_ x:Double) -> Double { x * x }

func derivative(_ x:Double) -> Double { 2 * x }

private func test_derivative() {
    let xs = (-10..<11)
    let actuals = xs.map {derivative(Double($0))}
    let estimates = xs.map {difference_quotient(f: square(_:), x:Double($0), h: 0.001)}
}

private let test1 = test_derivative()


// p104

private func partial_difference_quotient(f:(Vector) -> Double,
                                 v:Vector,
                                 i:Int,
                                 h:Double) -> Double {
    //let r = (f(x + h) - f(x)) / h
    var w:Vector = []
    
    for (j, v_j) in v.enumerated() {
        let a:Double
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

private func estimate_gradient(f:(Vector) -> Double,
                       v:Vector,
                       h:Double = 0.0001) -> Vector {
    var vec:Vector = []
    
    for i in 0 ..< v.count {
        let p = partial_difference_quotient(f: f, v: v, i: i, h: h)
        vec.append(p)
    }
    return vec
}

public func gradient_step(v:Vector, gradient:Vector, step_size:Double) -> Vector {
    assert(v.count == gradient.count)
    let step = scalar_multiply(step_size, gradient)
    return add(v, step)
}

func sum_of_squares_gradient(_ v:Vector) -> Vector {
    v.map {2 * $0}
}

private func use_gradient() {
    var v:Vector = (0..<3).map {_ in Double.random(in: -10...10)}
    
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

func linear_gradient(x:Double, y:Double, theta:Vector) -> Vector {
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
private func use_gradient2(learning_rate:Double = 0.001) {
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    var theta:Vector = [Double.random(in: -1...1), Double.random(in: -1...1)]
    //let learning_rate:Float = 0.001
    
    for epoch in 0..<5000 {
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Double(x), y: Double(y), theta: theta)
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

private func test_minibatch(learning_rate:Double = 0.001) {
    var theta:Vector = [Double.random(in: -1...1), Double.random(in: -1...1)]
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    
    for epoch in 0..<1000 {
        let batches = minibatches(dataset: inputs, batch_size: 20)
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Double(x), y: Double(y), theta: theta)
            let grad = vector_mean([lgrads])
            theta = gradient_step(v: theta, gradient: grad, step_size: -learning_rate)
            print("\(epoch), \(theta)")
        }
    }
}

// p109

private func test_stochastic_gradient_descent(learning_rate:Double = 0.001) {
    var theta:Vector = [Double.random(in: -1...1), Double.random(in: -1...1)]
    let inputs:[(Int,Int)] = (-50...49).map {($0, 20 * $0 + 5)}
    
    for epoch in 0..<100 {
        for (x, y) in inputs {
            let lgrads:Vector = linear_gradient(x: Double(x), y: Double(y), theta: theta)
            let grad = vector_mean([lgrads])
            theta = gradient_step(v: theta, gradient: grad, step_size: -learning_rate)
            print("\(epoch), \(theta)")
        }
    }
}


