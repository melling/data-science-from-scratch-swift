/*
 Data Science from Scratch
 Joel Grus
 Chapter 5: Statistics
 Implemented in Swift 5.x
 
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
    
    func quantile(p: Float) -> Element {
        let p_index0 = p * Float(self.count)  // p:Element doesn't work
        let p_index:Int = Int(p_index0)
        return self.sorted()[p_index]
    }
 
 // Need Counter - pg 66
    func mode() -> [Element] {
        
        return []
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
    
    func covariance(ys:[Element]) -> Float {
        assert(self.count == ys.count, "xs and ys must have same number of elements")
        let n:Float = Float(self.count - 1)
        return dot(self.de_mean() as! Vector, ys.de_mean() as! Vector) /  n
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

assert(num_friends.quantile(p: 0.10) == 1)
assert(num_friends.quantile(p: 0.25) == 3)
assert(num_friends.quantile(p: 0.75) == 9)
assert(num_friends.quantile(p: 0.90) == 13)

