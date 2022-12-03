import Foundation
import Darwin 

func initPriorityMap() -> [Character: Int] {
    var priorityMap: [Character: Int] = [:]
    var currentLowerChar: Character = "a"
    var currentHigherChar: Character = "A"
    
    for i in 1...26 { // "..." is the range operator and is inclusive of the last value
        priorityMap[currentLowerChar] = i
        // Print the ascii value of the character
        currentLowerChar = Character(UnicodeScalar(currentLowerChar.asciiValue! + 1))
    }
    
    for j in 27...52 { 
        priorityMap[currentHigherChar] = j
        // Move to the next character 
        currentHigherChar = Character(UnicodeScalar(currentHigherChar.asciiValue! + 1))
    }

    return priorityMap
}

func splitCompartments(_ rucksack: String) -> (left: String.SubSequence, right: String.SubSequence) {
    let midIndex = rucksack.index(rucksack.startIndex, offsetBy: rucksack.count / 2)
    let left = rucksack[..<midIndex]
    let right = rucksack[midIndex...]
    return (left, right)
}


func calculatePriority(rucksack: String, _ priorityMap: [Character:Int]) -> Int {
    let compartments = splitCompartments(rucksack)
    // Get the intersection of left and right compartments
    var leftMap: [Character: Int] = [:]
    for char in compartments.left {
        leftMap[char] = 1
    }
    for char in compartments.right {
        if leftMap[char] != nil {
            return priorityMap[char]!
        }
    }
    return 0
}

func main() {
    // Get the number of arguments
    let argc = Int(CommandLine.argc)
    if argc != 2 {
        print("Usage: \(CommandLine.arguments[0]) <filename>")
        exit(1)
    }

    let filename = CommandLine.arguments[1]

    guard let contents = try? String(contentsOfFile: filename, encoding: .utf8) else {
        print("Could not open file \(filename)")
        exit(1)
    }
    
    // Code here
    let rucksacks: [String] = contents.components(separatedBy: "\n")
    let priorityMap = initPriorityMap()
    var priority: Int = 0
    for rucksack in rucksacks {
        priority += calculatePriority(rucksack: rucksack, priorityMap)
    }
    print(priority)
    exit(0)
}

main()

