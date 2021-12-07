import UIKit

var greeting = "Hello"

func returnReversed(greeting: String) -> String {
    return String(greeting.reversed())
}

returnReversed(greeting: greeting)

//input: "Ana, she loves to eat at noon with Bob, Mike and Peter"
//output: [Ana, noon, Bob]

