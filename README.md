# Data Science from Scratch Implemented in Swift

Data Science from Scratch<br/>
First Principles with ~~Python~~ **Swift**<br/>
Joel Grus

Book: https://www.amazon.com/Data-Science-Scratch-Principles-Python/dp/1492041130/

Book Python Source: https://github.com/joelgrus/data-science-from-scratch

--

- [Chapter 4: Linear Algebra](swift/linear_algebra.swift) 
- [Chapter 5: Statistics](swift/statistics.swift)
- [Chapter 6: Probability](swift/probability.swift)
- [Chapter 7: Hypothesis and Inference](swift/inference.swift)
- [Chapter 8: Gradient Descent](swift/gradient_descent.swift)
- [Chapter 14: Simple Linear Regression](swift/simple_linear_regression.swift)
- 
## TODO
- [Chapter 12: k-Nearest Neighbors](swift/k_nearest_neighbors.swift)
- [Chapter 13: Naive Bayes](swift/naive_bayes.swift)
- [Chapter 15: Multiple Regression](swift/multiple_regression.swift)
- [Chapter 16: Logistic Regression](swift/logistic_regression.swift)


## Overview

Reimplementing in Swift because it's a great modern language.  Any language will do, of course. However, if I did it with Python, I'd probably cheat a little and I would definitely not think about what I'm doing as much.
 
 ## Misc Thoughts and Issues
 
 - Sticking with snake_case variable names for consistency
 - Implemented some functions as Array extensions in Chapter 5.
    - Which is better variance(xs) vs xs.variance?
 - Used FloatingPoint protocol so I had to force type to float by adding .0 in some instances.
 - Type issues: Tried to use FloatingPoint protocol to make functions more generic.  Had problems casting Element results to Float.
 - Needed two linear algebra functions from Chapter 4: dot(), sum_of_squares().  I simply copied them into the statistics.swift file.
 - Also, copied the Vector type.
 - Need a plotting library.  
 
 ### Python's List Comprehensions
 
 Pyhon's List Comprehension are a nice succinct feature.  In Swift, you'll need to replace them with a combination of map, filter, forEach, for, etc  I've rewritten some of the examples on page 30 in Swift:
 
 #### Python
 
 ```python
even_numbers = [x for x in range(5) if x % 2 == 0]  # [0, 2, 4]
squares      = [x * x for x in range(5)]            # [0, 1, 4, 9, 16]
even_squares = [x * x for x in even_numbers]        # [0, 4, 16]


assert even_numbers == [0, 2, 4]
assert squares == [0, 1, 4, 9, 16]
assert even_squares == [0, 4, 16]

square_dict = {x: x * x for x in range(5)}  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
square_set  = {x * x for x in [1, -1]}      # {1}


assert square_dict == {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
assert square_set == {1}

zeros = [0 for _ in even_numbers]      # has the same length as even_numbers


assert zeros == [0, 0, 0]

```

 
#### Swift

```swift
let even_numbers = (0..<5).filter {$0 % 2 == 0}
let squares = (0..<5).map {$0 * $0}
let even_squares = (0..<5).map {$0 * $0}.filter {$0 % 2 == 0}

var square_dict:[Int:Int] = [:]
(0..<5).forEach {square_dict[$0] = $0 * $0}

let zeros = even_numbers.map {_ in 0}
```

 ### Simple implementation of Python's Counter (p26,66) class in Swift.
 
 ```swift
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
```
 
 
 Next I'll continue to work through the book.  Not sure if I'll do it in order.
 
