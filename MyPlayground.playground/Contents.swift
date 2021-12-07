import UIKit

//****************************************** Day One *******************************************************************

//Variable Creation
//Can be changed anytime
var favoriteShow = "Orange is the new black"
favoriteShow = "the good place"
favoriteShow = "Doctor Who"

var meaningOfLife = 42

var quote = "Change the world by being yourself"

var isEnable = false

//Cant't be changed after declaration
let names: String

//Multiline Text string string interpolation

var burns = """
Thr best laid schemes
O'mice and men
Gang aft agley
"""

var city = "Cardiff"
var message = "Welcome to \(city)"

//Double explanation
// Cant't join them they are different
var myInt = 1
var myDouble = 1.0

//Type Annotations
var percentage: Double = 99
var name: String

//****************************************** Day Two *******************************************************************

//Arrays
//Arrays are collections of values that are stored as a single value
let jhon = "Jhon Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [jhon, paul, george, ringo]

beatles[0]

//Empty arrays declaration
var emptyDoubles: [Double] = []
//Empty declaration type Anotations
var doubleType: Array<Double> = Array()
//Array pre initialized where repeating is the type anotation declaration
var digitsCounts: Array<Any> = Array(repeating: 1, count: 10)
//
var digitsCounts2 = Array(repeating: "leandro", count: 10)

//Accessing Array Values
for band in beatles {
    print("I love \(band)")
    
    if band == "Ringo Starr" {
        print("\(band) is apple in japanese")
    }else {
        continue
    }
}

//Sets
/*Sets are just like Arrays, but with two differences:
 1. Items arent sorted in any order
 2. No item can appear twice in a set, it must be unique */

//Set Declaration
let colors = Set(["red", "green", "blue"])
//Sets with duplicate values, the duplicated value gets ignored
let colors2 = Set(["red", "green", "blue", "red", "blue"])

//Tuples
/*Tuples allow you to store several values together in a single value, but differs from tuple Arrays in three aspects:
 1. You can't add or remove items from tuples, they are fixed size
 2. You can't change the types of items in a tuple, they always have the same types they were created with
 3. You can access items in a tuple using numerical positions or by naming them, but Swift wont let you read numbers
or names that dont rxists */

//Tuple declarations
var fullName = (first: "Tylor", last: "Swift")
//Tuple accessing values
fullName.0
fullName.first
fullName.last

//Comparison between Array, sets and tuples
//If you need a specific, fixed collection of related values where each item has a precise position or name you shoul use tuple
let address = (house: 555, street: "Tylor Swift Avenue", city: "NashVille")
//if you need a collection of values that must be unique or you need to be able to check whether as specific item is in there quickly, use a set
let set = Set(["aardvak", "astronaut", "azalea"])
//If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

//Dictionaries
//Dictionaries are collections of values just like arrays, but rather than storing things with an integer position you can access them using anything you want.
let heigts = [
    "Tylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

heigts["Tylor Swift"]
//Dictionary with default values
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]
favoriteIceCream["Charlotte", default: "Unknown"]

//Create empty Collection
//empty dictionary
var teams = [String: String]()
teams["Paul"] = "Red"
print(teams)
//empty arrays
var results = [Int]()
//empty Sets
var words = Set<String>()
var numbers = Set<Int>()

//Enumerators
let result = "failure"
let result2 = "failed"
let result3 = "fail"

enum Result {
    case success
    case failure
}

let result4 = Result.failure
//Enum with associated types
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "soccer")

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

//****************************************** Day Three *******************************************************************

// Operators
let valu2: Double = 90000000000000001
//changin for int to not lost value
let value: Int = 90000000000000001

let weeks = 465 / 7
print("There are \(weeks) weeks until the event.")

let firstName = "Paul"
let secondName = "Sophie"

let firstAge = 40
let secondAge = 10

print(firstName == secondName)
print(firstName != secondName)
print(firstName < secondName)
print(firstName >= secondName)

print(firstAge == secondAge)
print(firstAge != secondAge)
print(firstAge < secondAge)
print(firstAge >= secondAge)


enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large

print(first > second)

let score = 9001

if score > 9000 {
    print("It's over 9000!")
} else {
    if score == 9000 {
        print("It's exactly 9000!")
    } else {
        print("It's not over 9000!")
    }
}

if score > 9000 {
    print("It's over 9000!")
} else if score == 9000 {
    print("It's exactly 9000!")
} else {
    print("It's not over 9000!")
}

if score <= 9000 {
    print("It's not over 9000!")
}
