# Data Science from Scratch Implemented in Swift

Data Science from Scratch
First Principles with ~~Python~~ **Swift** - Joel Grus

Book: https://www.amazon.com/Data-Science-Scratch-Principles-Python/dp/1492041130/

Book Python Source: https://github.com/joelgrus/data-science-from-scratch

## Overview

Reimplementing in Swift because it's a great modern language.  Any language will do, of course. However, if I did it with Python, I'd probably cheat a little and I would definitely not think about what I'm doing as much.
 
 ## Misc Thoughts and Issues
 
 - Sticking with snake_case variable names for consistency
 - Implemented some functions as Array extensions in Chapter 5.
    - Which is better variance(xs) vs xs.variance?
 - Used FloatingPoint protocol so I had to force type to float by adding .0 in some instances.
 
 - Replace Python's list comprehensions with Swift's map
 
 - Type issues: Tried to use FloatingPoint protocol to make functions more generic.  Had problems casting Element results to Float.
 - Needed two linear algebra functions from Chapter 4: dot(), sum_of_squares().  I simply copied them into the statistics.swift file.
 - Also, copied the Vector type.
 
 Need a plotting library.  Histograms
 
 Swift equivalent Python Counter class on StackOverFlow
 
 Next I'll continue to work through the book.  Not sure if I'll do it in order.
 
