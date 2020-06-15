
/*
 
 Chapter 14: Simple Linear Regression
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/simple_linear_regression.py
 
 */
import Foundation //sqrt

// p186

func predict(alpha:Double, beta:Double, x_i:Double) -> Double {
    beta * x_i + alpha
}

func error(alpha:Double, beta:Double, x_i:Double, y_i:Double) -> Double {
    predict(alpha: alpha, beta: beta, x_i: x_i) - y_i
}


/*
 p186
 
 */

func sum_of_sqerrors(alpha:Double, beta:Double, x:Vector, y:Vector) -> Double {
    var sum:Double = 0
    for (x_i, y_i) in zip(x, y) {
        let s = error(alpha: alpha, beta: beta, x_i: x_i, y_i: y_i)
        sum += pow(s, 2)
    }
    return sum
}

/*
 
 */

func least_squares_fit(_ x:Vector, _ y:Vector)  -> (Double, Double) {
    let beta = x.correlation(y) * y.standard_deviation() / x.standard_deviation()
    let alpha = y.mean() - beta * x.mean()
    return (alpha, beta)
}

func test_least_squares() {
    let x:[Double] = stride(from: -100, to: 110, by: 10).map {Double($0)}
    let y:[Double] = x.map {3 * $0 - 5}
    print(y)
    let ans = least_squares_fit(x, y) // [-5, 3]
}

test_least_squares()


// p187 - TODO

// p188

func total_sum_of_squares(_ y:Vector) -> Double {
    let x:[Double] = y.de_mean().map {Double(pow($0,2))}
    let s = x.sum() // chain above?
    return s
}

func r_squared(alpha:Double, beta:Double, x:Vector, y:Vector) -> Double {
    1.0 - sum_of_sqerrors(alpha: alpha, beta: beta, x: x, y: y) / total_sum_of_squares(y)
}

//
/*
 Copied from Statistics chapter
 
 */


func num_friends_good(outlier:Double) -> [Double] {
    var friends:[Double] = []
    let outlierIdx = num_friends.firstIndex(of: outlier)
    
    for (i, x) in num_friends.enumerated() {
        if i != outlierIdx {
            friends.append(x)
        }
    }
    return friends
    
}


func daily_minutes_good(outlier:Double) -> [Double] {
    var minutes:[Double] = []
    let outlierIdx = num_friends.firstIndex(of: outlier)
    //let outlier = num_friends[100]
    
    for (i, x) in daily_minutes.enumerated() {
        if i != outlierIdx {
            minutes.append(x)
        }
    }
    return minutes
}


let good_friends = num_friends_good(outlier: 100)
let good_minutes = daily_minutes_good(outlier: 100)

let daily_hours_good = good_minutes.map {$0 / 60.0}


// ===========
// p187

let (alpha, beta) = least_squares_fit(good_friends, good_minutes)
assert(alpha > 22.9 && alpha < 23.0)
assert(beta > 0.9 && beta < 0.905)

// p188

let rsq = r_squared(alpha: alpha, beta: beta, x: good_friends, y: good_minutes)
assert(rsq > 0.328 && rsq < 0.330)
