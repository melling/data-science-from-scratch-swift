
/*
 Chapter 7: Hypothesis and Inference
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/inference.py
 
 */
import Foundation // sqrt

/*
 Imports from Chapter 6: Probability
 
 - normal_cdf()
 - inverse_normal_cdf()
 
 */

// p88

func normal_approximation_to_binomial(_ n:Int, _ p:Double) -> (Double, Double) {
    let n0 = Double(n)
    let mu = p * n0
    let sigma = sqrt(p * (1 - p) * n0)
    return (mu, sigma)
}

//let normal_probability_below = normal_cdf
func normal_probability_below(x:Double, mu:Double = 0, sigma:Double = 1) -> Double {
    normal_cdf(x: x, mu: mu, sigma: sigma)
}

func normal_probability_above(lo:Double, mu:Double = 0, sigma:Double = 1) -> Double {
    1 - normal_cdf(x: lo, mu: mu, sigma: sigma)
}


func normal_probability_between(lo:Double,
                                hi:Double,
                                mu:Double = 0,
                                sigma:Double = 1) -> Double {
    normal_cdf(x: hi, mu: mu, sigma: sigma) - normal_cdf(x: lo, mu: mu, sigma: sigma)
}


func normal_probability_outside(lo:Double, 
                                hi:Double,
                                mu:Double = 0,
                                sigma:Double = 1) -> Double {
    1 - normal_probability_between(lo: lo, hi: hi, mu: mu, sigma: sigma)
}


// p89

func normal_upper_bound(probability:Double,
                        mu:Double = 0,
                        sigma:Double = 1) -> Double {
    inverse_normal_cdf(p: probability, mu: mu, sigma: sigma)
}

func normal_lower_bound(probability:Double,
                        mu:Double = 0,
                        sigma:Double = 1) -> Double {
    inverse_normal_cdf(p: 1 - probability, mu: mu, sigma: sigma)
}


func normal_two_sided_bounds(probability:Double,
                             mu:Double = 0,
                             sigma:Double = 1) -> (Double, Double) {
    
    let tail_probability = (1 - probability) / 2
    
    let upper_bound = normal_lower_bound(probability: tail_probability, mu: mu, sigma: sigma)
    
    let lower_bound = normal_upper_bound(probability: tail_probability, mu: mu, sigma: sigma)
    
    return (lower_bound, upper_bound)
}


private func test1() {
    // 500, 15.8
    let (mu_0, sigma_0) = normal_approximation_to_binomial(1000, 0.5)
    mu_0
    sigma_0
}

private let (mu_0, sigma_0) = normal_approximation_to_binomial(1000, 0.5)

private func test2() {
    // (469, 531)
    let (lower_bound, upper_bound) = normal_two_sided_bounds(probability: 0.95, mu: mu_0, sigma: sigma_0)
    lower_bound
    upper_bound
}


private func test3() {
    // p90
    
    var (hi, lo) = normal_two_sided_bounds(probability: 0.95, mu: mu_0, sigma: sigma_0)
    
    let (mu_1, sigma_1) = normal_approximation_to_binomial(1000, 0.55)
    mu_1
    sigma_1
    
    var type_2_probability = normal_probability_between(lo: lo, hi: hi, mu: mu_1, sigma: sigma_1)
    
    
    var power = 1 - type_2_probability // 0.887
    
    // 52
    hi = normal_upper_bound(probability: 0.95, mu: mu_0, sigma: sigma_0)
    type_2_probability = normal_probability_below(x: hi, mu: mu_1, sigma: sigma_1)
    
    power = 1 - type_2_probability // 0.936
}


/*
 p-Values
 p90
 
 */

func two_sided_p_value(x:Double, mu:Double = 0, sigma:Double = 1) -> Double {
    if x >= mu {
        return 2 * normal_probability_above(lo: x, mu: mu, sigma: sigma)
    } else {
        return 2 * normal_probability_below(x: x, mu: mu, sigma: sigma)
    }
}

private let t0 = two_sided_p_value(x: 529.5, mu: mu_0, sigma: sigma_0) // 0.062

private func test_extreme_value_count() {
    
    var extreme_value_count = 0
    for _ in 0..<1000 {
        var num_heads = 0
        for _ in 0..<1000 {
            if Double.random(in: 0...1) < 0.5 {
                num_heads += 1
            }
            
        }
        if num_heads >= 530 || num_heads <= 470 {
            extreme_value_count += 1
        }
        
    }
    print("extreme value count: \(extreme_value_count)") // 59 < x < 65
}

//test_extreme_value_count()


private func test4() {
    two_sided_p_value(x: 531.5, mu: mu_0, sigma: sigma_0) // 0.0463
    
    // upper_p_value
    normal_probability_above(lo: 524.5, mu: mu_0, sigma: sigma_0) // 0.061
    
    normal_probability_above(lo: 526.5, mu: mu_0, sigma: sigma_0) // 0.047
    
    
}


/*
 Confidence Intervals
 p92
 
 */
private func confidence1() {
    var p_hat:Double = 525.0 / 1000
    var mu = p_hat
    var sigma = sqrt(p_hat * (1 - p_hat) / 1000) // 0.0158
    //FIXME:
    normal_two_sided_bounds(probability: 0.95, mu: mu, sigma: sigma) // [0.4940, 0.5560]
}

private func confidence2() {
    var p_hat:Double = 540.0 / 1000
    var mu = p_hat
    var sigma = sqrt(p_hat * (1 - p_hat) / 1000) // 0.0158
    //FIXME:
    normal_two_sided_bounds(probability: 0.95, mu: mu, sigma: sigma) // [0.5091, 0.5709]
}

private let c1 = confidence1()
private let c2 = confidence2()



/*
 p-Hacking
 p93
 */

private func run_experiment() -> [Bool] {
    (1...1000).map { _ in Bool.random() } // 50% chance?
}


private func reject_fairness(experiment:[Bool]) -> Bool {
    let num_heads = experiment.filter {$0}.count
    return num_heads < 469 || num_heads > 531
}

private let ex1 = run_experiment()

private func test_experiment() {
    var num_rejections = 0
    for _ in 1...1000 {
        let ex = run_experiment()
        if reject_fairness(experiment: ex) {
            num_rejections += 1
        }
    }
    print("num_rejections=\(num_rejections)") // 46
}

private let ex2 = test_experiment()

/*
 
 Running an A/B Test
 p94
 
 */

private func estimated_parameters(_ N:Int, n:Int) -> (Double, Double) {
    let N0 = Double(N)
    let p:Double = Double(n) / N0
    let sigma = sqrt(p * (1 - p) / N0)
    return (p, sigma)
}

private func a_b_test_statistics(N_A:Int, n_A:Int, N_B:Int, n_B:Int) -> Double {
    let (p_A, sigma_A) = estimated_parameters(N_A, n: n_A)
    let (p_B, sigma_B) = estimated_parameters(N_B, n: n_B)
    let r =  (p_B - p_A) / sqrt(pow(sigma_A, 2) + pow(sigma_B, 2))
    return r
}


private func test5() {
    // -1.14
    var z = a_b_test_statistics(N_A: 1000, n_A: 200, N_B: 1000, n_B: 180)
    two_sided_p_value(x: z) // 0.254
    
    
    // -2.94
    z = a_b_test_statistics(N_A: 1000, n_A: 200, N_B: 1000, n_B: 150)
    two_sided_p_value(x: z) // 0.003
}




/*
 Bayesian Inference
 p95
 */
private func B(_ alpha:Float, _ beta:Float) ->Float {
    tgamma(alpha) * tgamma(beta) / tgamma(alpha + beta)
}

private func beta_pdf(_ x:Float, _ alpha:Float, _ beta:Float) -> Float {
    if x <= 0 || x >= 1 { return 0 }
    return pow(x, (alpha - 1)) * pow((1 - x), (beta - 1)) / B(alpha,beta)
}

//tgamma(6.0)
