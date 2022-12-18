import Foundation
import Darwin 

func isUnique(charMap: inout [Character:Int], fourArray: [Character]) -> Bool {
    for char in fourArray {
        if charMap[char] != nil {
            return false
        }
        charMap[char] = 1
    }
    return true
}

func charArrayToString(charArray: [Character]) -> String {
    var string = ""
    for char in charArray {
        string.append(char)
    }
    return string
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
    var fourArray: [Character] = []

    for i in 0..<4{
        let char = contents[contents.index(contents.startIndex, offsetBy: i)]
        fourArray.append(char)
    }

    var charMap: [Character:Int] = [:]

    if isUnique(charMap: &charMap, fourArray: fourArray) {
        print("Unique: \(fourArray)")
        exit(0)
    }

    // Since we already have the first four, start at index 4
    for i in 4..<contents.count {
        let char = contents[contents.index(contents.startIndex, offsetBy: i)]
        charMap[fourArray[0]] = nil
        fourArray.removeFirst()
        fourArray.append(char)
        var charMap: [Character:Int] = [:]
        if isUnique(charMap: &charMap, fourArray: fourArray) {
            print("Marker: \(charArrayToString(charArray: fourArray))")
            print(i + 1)
            exit(0)
        }
    }
}

main()


