import Foundation
import Darwin 

func getValues(section: String) -> (start: Int, end: Int) {
    // Given a section formatted as "1-3", return the left and right values
    let values = section.components(separatedBy: "-")
    return (Int(values[0])!, Int(values[1])!)
}

// Part 2 function 
func findPartialOverlap(pair: [String]) -> Bool {
    let firstSection = getValues(section: pair[0])
    let secondSection = getValues(section: pair[1])
    let condition1 = firstSection.end >= secondSection.start
    let condition2 = secondSection.end >= firstSection.start
    if firstSection.start < secondSection.start {
        return condition1
    }
    return condition2
}

// Part 1 function
func findFullOverlap(pair: [String]) -> Bool {
    let firstSection = getValues(section: pair[0])
    let secondSection = getValues(section: pair[1])
    // Condition for overlap:
    // If Section A starting number is greater than or equal to the starting number of Section B
    // If Section A ending number is less than or equal to the ending number of Section B
    // Second condition is the same but reversed (Section B)
    let condition1 =  secondSection.start >= firstSection.start && firstSection.end >= secondSection.end
    let condition2 = firstSection.start >= secondSection.start && secondSection.end >= firstSection.end
    return condition1 || condition2 // Return true if either condition evaluates to true
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
    // Split the contents
    var pairs = contents.components(separatedBy:"\n")
    pairs.removeLast()
    var fullOverlapCount = 0
    var partialOverlapCount = 0
    for pair in pairs {
        let formattedPair = pair.components(separatedBy: ",")
        if findFullOverlap(pair: formattedPair) {
            fullOverlapCount += 1
            partialOverlapCount += 1
            print("\(formattedPair)")
            continue
        }
        if findPartialOverlap(pair: formattedPair) {
            print("\(formattedPair)")
            partialOverlapCount += 1
        }
    }

    print("There are \(fullOverlapCount) fully overlapped sections")
    print("There are \(partialOverlapCount) fully and partially overlapped sections")
}

main()

