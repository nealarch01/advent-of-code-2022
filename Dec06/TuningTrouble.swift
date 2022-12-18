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

func findMessageMarker(dataStream: String, markCount: Int) -> Int {
    var markerArray: [Character] = []

    for i in 0..<markCount{
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        markerArray.append(char)
    }

    var charMap: [Character:Int] = [:]

    if isUnique(charMap: &charMap, charArray: markerArray) {
        print("Unique: \(markerArray)")
        exit(0)
    }

    // Since we already have the first fourteen, start at index 14
    for i in markCount..<dataStream.count {
        let char = dataStream[dataStream.index(dataStream.startIndex, offsetBy: i)]
        charMap[markerArray[0]] = nil
        markerArray.removeFirst()
        markerArray.append(char)
        var charMap: [Character:Int] = [:]
        if isUnique(charMap: &charMap, charArray: markerArray) {
            print("Marker: \(charArrayToString(charArray: markerArray))")
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
    // var _ = messageMarker4(dataStream: contents)
    // var _ = messageMarker14(dataStream: contents)
    var _ = findMessageMarker(dataStream: contents, markCount: 4)
    var _ = findMessageMarker(dataStream: contents, markCount: 14)
}

main()


