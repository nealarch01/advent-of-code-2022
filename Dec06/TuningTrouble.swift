import Foundation
import Darwin 

func isUnique(charMap: inout [Character:Int], charArray: [Character]) -> Bool {
    for char in charArray {
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

func messageMarker4(dataStream: String) -> Int {
    var fourArray: [Character] = []

    for i in 0..<4{
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        fourArray.append(char)
    }

    var charMap: [Character:Int] = [:]

    if isUnique(charMap: &charMap, charArray: fourArray) {
        print("Unique: \(fourArray)")
        exit(0)
    }

    // Since we already have the first four, start at index 4
    for i in 4..<dataStream.count {
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        charMap[fourArray[0]] = nil
        fourArray.removeFirst()
        fourArray.append(char)
        var charMap: [Character:Int] = [:]
        if isUnique(charMap: &charMap, charArray: fourArray) {
            print("Marker: \(charArrayToString(charArray: fourArray))")
            print(i + 1)
            return i + 1
        }
    }
    return 0
}

func messageMarker14(dataStream: String) -> Int {
    var fourteenArray: [Character] = []

    for i in 0..<14{
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        fourteenArray.append(char)
    }

    var charMap: [Character:Int] = [:]

    if isUnique(charMap: &charMap, charArray: fourteenArray) {
        print("Unique: \(fourteenArray)")
        exit(0)
    }

    // Since we already have the first fourteen, start at index 14
    for i in 14..<dataStream.count {
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        charMap[fourteenArray[0]] = nil
        fourteenArray.removeFirst()
        fourteenArray.append(char)
        var charMap: [Character:Int] = [:]
        if isUnique(charMap: &charMap, charArray: fourteenArray) {
            print("Marker: \(charArrayToString(charArray: fourteenArray))")
            print(i + 1)
            return i + 1
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
    var _ = messageMarker4(dataStream: contents)
    var _ = messageMarker14(dataStream: contents)
}

main()


