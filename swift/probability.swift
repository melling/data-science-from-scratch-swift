/*
 Chapter 6: Probability
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/probability.py
 */

import Foundation //sqrt, erf

// 77

enum Kid {
    case boy
    case girl
}

func random_kid() -> Kid {
    Bool.random() ? .boy : .girl
}

var both_girls = 0
var older_girl = 0
var either_girl = 0

for _ in 1 ... 10000 {
    let younger = random_kid()
    let older = random_kid()
    
    if older == .girl {
        older_girl += 1
    }
    if older == .girl && younger == .girl {
        both_girls += 1
    }
    if older == .girl || younger == .girl {
        either_girl += 1
    }
}

let both_older = Float(both_girls) / Float(older_girl)
let both_either = Float(both_girls) / Float(either_girl)

print("P(both | older): \(both_older)")   // 0.514 ~ 1/2
print("P(both | either): \(both_either)") // 0.342 ~ 1/3

// Continuous Distributions - p80 
func uniform_pdf(_ x:Float) -> Float {
    x >= 0 && x < 1 ? 1 : 0
}

func uniform_cdf(_ x:Float) -> Float {
    switch x {
    case _ where x < 0: return 0
    case _ where x < 1: return x
        
    default: return 1 
    }
    
}

// Normal Distributions - p81

func normal_pdf(x:Float, mu:Float = 0, sigma:Float = 1) -> Float {
    let sqrt_two_pi = sqrt(2 * Float.pi)
    let a = (x - mu)
    let numerator = pow(a, 2)
    let denominator = 2 * pow(sigma, 2)
    let x2 = exp(numerator / denominator * -1)
    let x3 = x2 / (sqrt_two_pi * sigma)
    return x3
}

/*
 
 https://en.wikipedia.org/wiki/Error_function
 
 https://swift.org/blog/numerics/
 
 https://stackoverflow.com/questions/36784763/is-there-an-inverse-error-function-available-in-swifts-foundation-import
 
 p83
 */
func normal_cdf(x:Float, mu:Float = 0, sigma:Float = 1) -> Float {
     (1 + erf((x - mu) / sqrt(2) / sigma)) / 2
}

func inverse_normal_cdf(p:Float, mu:Float = 0, sigma:Float = 1, tolerance:Float = 0.00001) -> Float {
    if mu != 0 || sigma != 1 {
        return  mu + sigma + inverse_normal_cdf(p: p, tolerance: tolerance)
    }
    var low_z:Float = -10.0
    var hi_z:Float = 10.0
    var mid_z:Float = 0
    while hi_z - low_z > tolerance {
         mid_z = (low_z + hi_z) / 2
        let mid_p = normal_cdf(x: mid_z)
        if mid_p < p {
            low_z = mid_z
        } else {
            hi_z = mid_z
        }
        
    }
    return mid_z
}

/*
 The Central Limit Theorem
 p84
 */

func bernoulli_trial(_ p:Float) -> Int {
    Float.random(in: 0...1) < p ? 1 : 0
}

func binomial(n:Int, p:Float) -> Int {
    if n == 0 {return 0}
    return bernoulli_trial(p) + binomial(n: n-1, p: p)
}
