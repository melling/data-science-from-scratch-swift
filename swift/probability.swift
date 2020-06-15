
/*
 Chapter 6: Probability
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/probability.py
 */

import Foundation //sqrt, erf

// 77

private enum Kid {
    case boy
    case girl
}

private func random_kid() -> Kid {
    Bool.random() ? .boy : .girl
}
func run0() {
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
    
    let both_older = Double(both_girls) / Double(older_girl)
    let both_either = Double(both_girls) / Double(either_girl)
    
    print("P(both | older): \(both_older)")   // 0.514 ~ 1/2
    print("P(both | either): \(both_either)") // 0.342 ~ 1/3
    
}


// Continuous Distributions - p80 
public func uniform_pdf(_ x:Double) -> Double {
    x >= 0 && x < 1 ? 1 : 0
}

public func uniform_cdf(_ x:Double) -> Double {
    switch x {
    case _ where x < 0: return 0
    case _ where x < 1: return x
        
    default: return 1 
    }
    
}

// Normal Distributions - p81

public func normal_pdf(x:Double, mu:Double = 0, sigma:Double = 1) -> Double {
    let sqrt_two_pi = sqrt(2 * Double.pi)
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
public func normal_cdf(x:Double, mu:Double = 0, sigma:Double = 1) -> Double {
    (1 + erf((x - mu) / sqrt(2) / sigma)) / 2
}

public func inverse_normal_cdf(p:Double, mu:Double = 0, sigma:Double = 1, tolerance:Double = 0.00001) -> Double {
    if mu != 0 || sigma != 1 {
        return  mu + sigma + inverse_normal_cdf(p: p, tolerance: tolerance)
    }
    var low_z:Double = -10.0
    var hi_z:Double = 10.0
    var mid_z:Double = 0
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

public func bernoulli_trial(_ p:Double) -> Int {
    Double.random(in: 0...1) < p ? 1 : 0
}

public func binomial(n:Int, p:Double) -> Int {
    if n == 0 {return 0}
    return bernoulli_trial(p) + binomial(n: n-1, p: p)
}

