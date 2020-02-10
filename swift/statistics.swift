/*
 Data Science from Scratch
 Joel Grus
 Chapter 5: Statistics
 Implemented in Swift 5.x
 Python: https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/statistics.py

 - Sticking with snake_case variable names for consistency
 - Implementing methods as Array extensions
 - Used FloatingPoint so I had to for type to float by adding .0 in some instances.
 
 */

import Foundation //sqrt

/*
 Linear Algebra functions from Chapter 4
 - dot()
 - sum_of_squares()
 */

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

/*
 A simple version of Python's Countable function
 */

class Counter<T:Hashable> {
    public var dict:[T:Int] = [:]
    public let maxCount:Int
    
    init(_ xs:[T]) {
        var max = 0
        
        for elem in xs {
            if let n = dict[elem] {
                dict[elem] = n + 1
                if n + 1 > max {
                    max = n + 1
                }
            } else {
                dict[elem] = 1
            }
        }
        
        maxCount = max
    }
    
    public func mode_values() -> [T] {
        var xs:[T] = []
        for (k,v) in dict {
            if v == maxCount {
                xs.append(k)
            }
        }
        return xs
    }
}


/*
 Implementing methods as Array extensions
 */
extension Array where Element: FloatingPoint  {
    
    var sum: Element {
        self.reduce(0, +)
    }
    
    var mean: Element {
        self.sum / Element(self.count)
    }
    
    var _medium_odd: Element { //pg 65
        self.sorted()[self.count / 2]
    }
    
    var _medium_even: Element { //pg 65
        let sorted_xs = self.sorted()
        let hi_midpoint = self.count / 2
        return (sorted_xs[hi_midpoint - 1] + sorted_xs[hi_midpoint]) / 2
    }
    
    var median: Element {
        self.count % 2 == 0 ? _medium_even : _medium_odd
    }
    
    func quantile(_ p: Float) -> Element {
        let p_index0 = p * Float(self.count)  // p:Element doesn't work
        let p_index:Int = Int(p_index0)
        return self.sorted()[p_index]
    }
 
 // Need Counter - pg 66
     func mode() -> [Element] {
        let ct = Counter(self)
        let modeList = ct.mode_values()
        //let counts = counter(self)
        return modeList
    }
 
    
    func data_range() -> Element {
        guard let max = self.max(), let min = self.min() else {return 0}
        return max - min
    }
    
    private func de_mean() -> [Element] {
        let x_bar = self.mean
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
    
    // FIXME: Problem mixing Float and Element
    func interquartile() -> Element {
        let x: Element = (self.quantile(0.75) - self.quantile(0.25))
        return x
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


let num_friends:[Float] = [100.0,49,41,40,25,21,21,19,19,18,18,16,15,15,15,15,14,14,13,13,13,13,12,12,11,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]

// Page 64
let s = num_friends.sum

let num_points = num_friends.count // 204

let largest_value = num_friends.max()
var smallest_value = num_friends.min()

let sorted_values = num_friends.sorted()
smallest_value = sorted_values[0]
let second_smallest_value = sorted_values[1]
let second_largest_value = sorted_values[sorted_values.count-2]

num_friends.mean

/*
 
 Central Tendencies
 pg 65
 
 */

assert([1.0, 10, 2, 9,5.0].median == 5)
assert([1.0, 9, 2, 10].median == (2.0 + 9)/2)

print("\(num_friends.median)") // 6

assert(num_friends.quantile(0.10) == 1)
assert(num_friends.quantile(0.25) == 3)
assert(num_friends.quantile(0.75) == 9)
assert(num_friends.quantile(0.90) == 13)

assert(Set(num_friends.mode()) == Set([1,6]))

// Dispersion - pg 67

assert(num_friends.data_range() == 99)


assert(81.54 < num_friends.variance() && num_friends.variance() < 81.55)

assert(9.02 < num_friends.standard_deviation() && num_friends.standard_deviation() < 9.04)

num_friends.standard_deviation()

assert(num_friends.interquartile()  == 6)
num_friends.interquartile()

// Correlation - pg 68

let daily_minutes:[Float] = [1,68.77,51.25,52.08,38.36,44.54,57.13,51.4,41.42,31.22,34.76,54.01,38.79,47.59,49.1,27.66,41.03,36.73,48.65,28.12,46.62,35.57,32.98,35,26.07,23.77,39.73,40.57,31.65,31.21,36.32,20.45,21.93,26.02,27.34,23.49,46.94,30.5,33.8,24.23,21.4,27.94,32.24,40.57,25.07,19.42,22.39,18.42,46.96,23.72,26.41,26.97,36.76,40.32,35.02,29.47,30.2,31,38.11,38.18,36.31,21.03,30.86,36.07,28.66,29.08,37.28,15.28,24.17,22.31,30.17,25.53,19.85,35.37,44.6,17.23,13.47,26.33,35.02,32.09,24.81,19.33,28.77,24.26,31.98,25.73,24.86,16.28,34.51,15.23,39.72,40.8,26.06,35.76,34.76,16.13,44.04,18.03,19.65,32.62,35.59,39.43,14.18,35.24,40.13,41.82,35.45,36.07,43.67,24.61,20.9,21.9,18.79,27.61,27.21,26.61,29.77,20.59,27.53,13.82,33.2,25,33.1,36.65,18.63,14.87,22.2,36.81,25.53,24.62,26.25,18.21,28.08,19.42,29.79,32.8,35.99,28.32,27.79,35.88,29.06,36.28,14.1,36.63,37.49,26.9,18.58,38.48,24.48,18.95,33.55,14.24,29.04,32.51,25.63,22.22,19,32.73,15.16,13.9,27.2,32.01,29.27,33,13.74,20.42,27.32,18.23,35.35,28.48,9.08,24.62,20.12,35.26,19.92,31.02,16.49,12.16,30.7,31.22,34.65,13.13,27.51,33.2,31.57,14.1,33.42,17.44,10.12,24.42,9.82,23.39,30.93,15.03,21.67,31.09,33.29,22.61,26.89,23.48,8.38,27.81,32.35,23.84]

// daily_hours = [dm / 60 for dm in daily_minutes]
let daily_hours = daily_minutes.map {$0 / 60}
let cov1 = num_friends.covariance(daily_minutes)
assert(22.42 < cov1 && cov1 < 22.43)
//assert 22.42 / 60 < covariance(num_friends, daily_hours) < 22.43 / 60
let cov2 = num_friends.covariance(daily_hours)
assert(22.42 / 60 < cov2 && cov2 < 22.43 / 60)

//
let corr1 = num_friends.correlation(daily_minutes)
let corr2 = num_friends.correlation(daily_hours)

assert(0.24 < corr1 && corr1 < 0.25)
assert(0.24 < corr2 && corr2 < 0.25)
