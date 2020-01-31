# Data Science from Scratch Implemented in Swift

Data Science from Scratch<br/>
First Principles with ~~Python~~ **Swift**<br/>
Joel Grus

Book: https://www.amazon.com/Data-Science-Scratch-Principles-Python/dp/1492041130/

Book Python Source: https://github.com/joelgrus/data-science-from-scratch

--

[Chapter 4: Linear Algebra](swift/linear_algebra.swift) | [Chapter 5: Statistics](swift/statistics.swift)


## Overview

Reimplementing in Swift because it's a great modern language.  Any language will do, of course. However, if I did it with Python, I'd probably cheat a little and I would definitely not think about what I'm doing as much.
 
 ## Misc Thoughts and Issues
 
 - Sticking with snake_case variable names for consistency
 - Implemented some functions as Array extensions in Chapter 5.
    - Which is better variance(xs) vs xs.variance?
 - Used FloatingPoint protocol so I had to force type to float by adding .0 in some instances.
 
 - [Often] Replace Python's list comprehensions with Swift's map
 
 - Type issues: Tried to use FloatingPoint protocol to make functions more generic.  Had problems casting Element results to Float.
 - Needed two linear algebra functions from Chapter 4: dot(), sum_of_squares().  I simply copied them into the statistics.swift file.
 - Also, copied the Vector type.
 
 Need a plotting library.  Histograms
 
 Simple implementation of Python's Counter (p26,66) class in Swift.
 
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
 
