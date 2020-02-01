/*
 Chapter 6: Probability
 
 https://github.com/joelgrus/data-science-from-scratch/blob/master/scratch/probability.py
 */


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
