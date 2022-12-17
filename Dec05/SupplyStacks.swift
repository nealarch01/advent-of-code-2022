
import Foundation
import Darwin 

struct SupplyStack {
    private(set) var items: [String]

    mutating func pushBack(item: String) {
        items.append(item)
    }

    mutating func pushFront(item: String) {
        items.insert(item, at: 0)
    }

    mutating func popBack() -> String {
        return items.removeLast()
    }

    func isEmpty() -> Bool {
        if items.count == 0 {
            return true
        }
        return false
    }

    init() {
        items = [] // Initialize an empty array
    }
}

func display(supplyStacks: [SupplyStack]) {
    print("==================")
    for (index, stack) in supplyStacks.enumerated() {
        print("Stack \(index + 1): \(stack.items)")
    }
    print("==================")
}

func crateMover9000(instruction: String, supplyStacks: inout [SupplyStack]) -> Void {
    // Instruction format: "move 1 from 2 to 1"
    // print("Instruction: \(instruction)")
    let instructionArray = instruction.components(separatedBy: " ")
    let quantity = Int(instructionArray[1])!
    let fromStack = Int(instructionArray[3])!
    let toStack = Int(instructionArray[5])!
    for _ in 0..<quantity {
        supplyStacks[toStack - 1].pushBack(item: supplyStacks[fromStack - 1].popBack())
    }
    // display(supplyStacks: supplyStacks)
}

func crateMover9001(instruction: String, supplyStacks: inout [SupplyStack]) -> Void {
    let instructionArray = instruction.components(separatedBy: " ")
    let quantity = Int(instructionArray[1])!
    let fromStack = Int(instructionArray[3])!
    let toStack = Int(instructionArray[5])!
    var tempStack = SupplyStack()
    for _ in 0..<quantity {
        tempStack.pushBack(item: supplyStacks[fromStack - 1].popBack())
    }
    while !tempStack.isEmpty() {
        supplyStacks[toStack - 1].pushBack(item: tempStack.popBack())
    }
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
    var lines = contents.components(separatedBy: "\n") // Split the read data into lines
    lines.removeLast() // Last line is an empty string, so remove it
    var i = 0
    var stackMap: [[String]] = []
    for line in lines {
        if line == "" {
            break
        }
        // .components changes the size of the array, to keep the consistency of the array, we need to use a temp array
        var lineArray: [String] = []
        for char in line {
            lineArray.append(String(char))
        }
        stackMap.append(lineArray)
        i += 1
    } 

    let stackNumbers = stackMap[stackMap.count - 1] // Separate the numbers into an array
    stackMap.removeLast()
    var supplyStacks9000: [SupplyStack] = []
    var supplyStacks9001: [SupplyStack] = []
    for (index, element) in stackNumbers.enumerated() {
        if element == " " {
            continue
        }
        var supplyStack = SupplyStack()
        for crate in stackMap {
            if crate[index] == " " {
                continue
            }
            supplyStack.pushFront(item: crate[index])
        }
        supplyStacks9000.append(supplyStack)
        supplyStacks9001.append(supplyStack)
    }
    // display(supplyStacks: supplyStacks)
    // Continue iterating through lines starting at i + 1
    for j in i + 1..<lines.count {
        crateMover9000(instruction: lines[j], supplyStacks: &supplyStacks9000)
        crateMover9001(instruction: lines[j], supplyStacks: &supplyStacks9001)
    }

    // display(supplyStacks: supplyStacks)

    // Print the elements at the top of all stacks
    var result9000: String = "Using crate mover 9000: "
    var result9001: String = "Using crate mover 9001: "
    for (_, stack) in supplyStacks9000.enumerated() {
        // print("Stack \(index + 1): \(stack.items.last!)")
        result9000 += stack.items.last!
    }

    for (_, stack) in supplyStacks9001.enumerated() {
        // print("Stack \(index + 1): \(stack.items.last!)")
        result9001 += stack.items.last!
    }
    print(result9000)
    print(result9001)
}

main()

