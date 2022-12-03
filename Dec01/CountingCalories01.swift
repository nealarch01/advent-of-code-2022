import Foundation
import Darwin 

func stringToInt(_ str: String) -> Int {
    guard let int = Int(str) else {
        print("Unexpected input")
        exit(3)
    }
    return int
}

struct Elf {
    private(set) var id: Int 
    private(set) var calories: Int

    init(id: Int, calories: Int) {
        self.id = id
        self.calories = calories
    }
}

// Part 1 and 2
func CountCalories(inputs: [String]) -> [Elf] {
    var elves: [Elf] = []
    var calories: Int = 0 
    var currentID: Int = 1
    for input in inputs {
       if input == "" { // Note, at the end of the input, there is an empty line indicating eof. No need to create a new elf
            elves.append(Elf(id: currentID, calories: calories))
            calories = 0
            currentID += 1
            continue 
        }
        calories += stringToInt(input)
    }
    elves = elves.sorted(by: {
        $0.calories > $1.calories // Sorts by ascending 
    })
    return elves
}

func main() {
    // Get the number of arguments
    let argc = Int(CommandLine.argc)
    if argc != 2 {
        print("Usage: \(CommandLine.arguments[0]) <filename>")
        exit(1)
    }

    let filename: String = CommandLine.arguments[1]

    guard let contents: String = try? String(contentsOfFile: filename, encoding: .utf8) else {
        print("Could not open file \(filename)")
        exit(1)
    }

    let inputs: [String] = contents.components(separatedBy: "\n") // Splits into an array of string by new line delimiter. Note: last index is an empty string
    let elves: [Elf] = CountCalories(inputs: inputs) 
    print("The elf with the most calories is \(elves[0].id) with \(elves[0].calories) calories")
    print("The elf with the second most calories is \(elves[1].id) with \(elves[1].calories) calories")
    print("The elf with the third most calories is \(elves[2].id) with \(elves[2].calories) calories")
    print("The top three elves have a combined total of \(elves[0].calories + elves[1].calories + elves[2].calories) calories")
    exit(0)
}

main()

