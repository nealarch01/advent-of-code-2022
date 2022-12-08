import Foundation
import Darwin 

class ElfGroup {
    private(set) var groupNumber: Int
    private(set) var rucksacks: [String]

    init(groupNumber: Int, rucksacks: [String]) {
        self.groupNumber = groupNumber
        self.rucksacks = rucksacks
    }
    
    private func mapCharacters(_ rucksack: String, _ characterMap: inout [Character:Int]) {
        var localMap: [Character:Int] = [:]
        for item in rucksack {
            if localMap[item] == nil { // If it is the first time we have visited
                if characterMap[item] == nil { // This does not exist
                    characterMap[item] = 1 // Set first instance
                } else { // Already exists, in a previous rucksack, so increment
                    characterMap[item]! += 1
                }
                localMap[item] = 1 // Set first instance
            }
        }
    }

    func groupPriority(_ priorityMap: inout [Character:Int]) -> Int {
        var characterMap: [Character: Int] = [:]
        for rucksack in rucksacks {
            mapCharacters(rucksack, &characterMap)
        }
        let sortedMap = characterMap.sorted { $0.value > $1.value }
        let top = sortedMap[0].key
        return priorityMap[top]!
    }
    
}

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


func calculatePriority(_ rucksack: String, _ priorityMap: inout [Character:Int]) -> Int {
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


func getElfGroups(_ rucksacks: [String]) -> [ElfGroup] {
    var elfGroups: [ElfGroup] = []
    var threeRucksacks: [String] = []
    for (index, rucksack) in rucksacks.enumerated() {
        threeRucksacks.append(rucksack)
        if (index + 1) % 3 == 0 {
            elfGroups.append(ElfGroup(groupNumber: elfGroups.count + 1, rucksacks: threeRucksacks))
            threeRucksacks = []
        }
    }
    return elfGroups
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
    var priorityMap = initPriorityMap()
    var priority: Int = 0
    for rucksack in rucksacks {
        priority += calculatePriority(rucksack, &priorityMap)
    }
    print("The priority is: \(priority)")
    let elfGroups = getElfGroups(rucksacks)
    var sumOfPriorities: Int = 0
    for elfGroup in elfGroups {
        sumOfPriorities += elfGroup.groupPriority(&priorityMap)
    }
    print("The sum of priorities is: \(sumOfPriorities)")
    exit(0)
}

main()

