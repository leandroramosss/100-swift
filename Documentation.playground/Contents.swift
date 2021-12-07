import Foundation

// Arrays

//Declaration array of Int
let oddNumbers = [1, 3, 5, 7, 9, 11, 13, 15]
// Declaration array of Strings
let streets = ["Alméria", "Malaga", "Valencia", "Vigo"]
//Empty declaration of an array
var emptyDoubles: [Double] = []
//Full type declarations
var emptyFloats: Array<Float> = Array()
// Array pre-initialized
var digitsCounts = Array(repeating: 0, count: 20)

// Accessing array values

for street in streets {
    print("I don't live on \(street)")
}
// Check if is empty
if oddNumbers.isEmpty {
    print("array is empty")
} else {
    //Check the count
    print("I know \(oddNumbers.count) odd numbers.")
}
