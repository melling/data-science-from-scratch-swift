
/*
 
 Chapter 14: Simple Linear Regression
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/simple_linear_regression.py
 
 */
import Foundation //sqrt

// p186

func predict(alpha:Float, beta:Float, x_i:Float) -> Float {
    beta * x_i + alpha
}

func error(alpha:Float, beta:Float, x_i:Float, y_i:Float) -> Float {
    predict(alpha: alpha, beta: beta, x_i: x_i) - y_i
}

/*
 Simply copy imports, for now
 
 */

// Import Linear Algebra Library
typealias Vector = [Float]

func dot(_ v:Vector, _ w:Vector) -> Float {
    assert(v.count == w.count, "vectors must be the same length")
    var total:Float = 0
    for (v_i, w_i) in zip(v, w) {
        total += v_i * w_i
    }
    return total
}


func sum_of_squares(_ v:Vector) -> Float {dot(v, v)}

// Import Statistics Library: correlation, standard_deviation, mean

extension Sequence where Element: AdditiveArithmetic {
    
    func sum() -> Element {
        reduce(.zero, +)
    }
}

extension Array where Element: FloatingPoint  {
    
    
    func mean() -> Element {
        self.sum() / Element(self.count)
    }

     func de_mean() -> [Element] {
        let x_bar = self.mean()
        let de = self.map {$0 - x_bar}
        return de
    }
    
    func variance() -> Float {
        assert(self.count >= 2, "variance requires at least 2 elements")
        
        let n:Float = Float(self.count)
        let deviations = self.de_mean()
        return sum_of_squares(deviations as! Vector) / (n - 1)
    }
    
    func standard_deviation() -> Float {
        sqrt(self.variance())
    }
    
    
    func covariance(_ ys:[Element]) -> Float {
        assert(self.count == ys.count, "xs and ys must have same number of elements")
        let n:Float = Float(self.count - 1)
        return dot(self.de_mean() as! Vector, ys.de_mean() as! Vector) /  n
    }
    
    func correlation(_ ys:[Element]) -> Float {
        let corr:Float
        
        let stdev_x = self.standard_deviation()
        let stdev_y = ys.standard_deviation()
        
        if stdev_x > 0 && stdev_y > 0 {
            corr = self.covariance(ys) / stdev_x / stdev_y
        } else {
            corr = 0
        }
        return corr
    }
}

/*
 p186
 
 */

func sum_of_sqerrors(alpha:Float, beta:Float, x:Vector, y:Vector) -> Float {
    var sum:Float = 0
    for (x_i, y_i) in zip(x, y) {
        let s = error(alpha: alpha, beta: beta, x_i: x_i, y_i: y_i)
        sum += pow(s, 2)
    }
    return sum
}

/*
 
 */

func least_squares_fit(_ x:Vector, _ y:Vector)  -> (Float, Float) {
    let beta = x.correlation(y) * y.standard_deviation() / x.standard_deviation()
    let alpha = y.mean() - beta * x.mean()
    return (alpha, beta)
}

func test_least_squares() {
    let x:[Float] = stride(from: -100, to: 110, by: 10).map {Float($0)}
    let y:[Float] = x.map {3 * $0 - 5}
    print(y)
    let ans = least_squares_fit(x, y) // [-5, 3]
}

test_least_squares()


// p187 - TODO

// p188

func total_sum_of_squares(_ y:Vector) -> Float {
    let x:[Float] = y.de_mean().map {Float(pow($0,2))}
    let s = x.sum() // chain above?
    return s
}

func r_squared(alpha:Float, beta:Float, x:Vector, y:Vector) -> Float {
    1.0 - sum_of_sqerrors(alpha: alpha, beta: beta, x: x, y: y) / total_sum_of_squares(y)
}

//
/*
 Copied from Statistics chapter
 
 */

let num_friends:[Float] = [100.0,49,41,40,25,21,21,19,19,18,18,16,15,15,15,15,14,14,13,13,13,13,12,12,11,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

let daily_minutes:[Float] = [1,68.77,51.25,52.08,38.36,44.54,57.13,51.4,41.42,31.22,34.76,54.01,38.79,47.59,49.1,27.66,41.03,36.73,48.65,28.12,46.62,35.57,32.98,35,26.07,23.77,39.73,40.57,31.65,31.21,36.32,20.45,21.93,26.02,27.34,23.49,46.94,30.5,33.8,24.23,21.4,27.94,32.24,40.57,25.07,19.42,22.39,18.42,46.96,23.72,26.41,26.97,36.76,40.32,35.02,29.47,30.2,31,38.11,38.18,36.31,21.03,30.86,36.07,28.66,29.08,37.28,15.28,24.17,22.31,30.17,25.53,19.85,35.37,44.6,17.23,13.47,26.33,35.02,32.09,24.81,19.33,28.77,24.26,31.98,25.73,24.86,16.28,34.51,15.23,39.72,40.8,26.06,35.76,34.76,16.13,44.04,18.03,19.65,32.62,35.59,39.43,14.18,35.24,40.13,41.82,35.45,36.07,43.67,24.61,20.9,21.9,18.79,27.61,27.21,26.61,29.77,20.59,27.53,13.82,33.2,25,33.1,36.65,18.63,14.87,22.2,36.81,25.53,24.62,26.25,18.21,28.08,19.42,29.79,32.8,35.99,28.32,27.79,35.88,29.06,36.28,14.1,36.63,37.49,26.9,18.58,38.48,24.48,18.95,33.55,14.24,29.04,32.51,25.63,22.22,19,32.73,15.16,13.9,27.2,32.01,29.27,33,13.74,20.42,27.32,18.23,35.35,28.48,9.08,24.62,20.12,35.26,19.92,31.02,16.49,12.16,30.7,31.22,34.65,13.13,27.51,33.2,31.57,14.1,33.42,17.44,10.12,24.42,9.82,23.39,30.93,15.03,21.67,31.09,33.29,22.61,26.89,23.48,8.38,27.81,32.35,23.84]

func num_friends_good(outlier:Float) -> [Float] {
    var friends:[Float] = []
    let outlierIdx = num_friends.firstIndex(of: outlier)
    
    for (i, x) in num_friends.enumerated() {
        if i != outlierIdx {
            friends.append(x)
        }
    }
    return friends
    
}


func daily_minutes_good(outlier:Float) -> [Float] {
    var minutes:[Float] = []
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
rsq
assert(rsq > 0.328 && rsq < 0.330)
