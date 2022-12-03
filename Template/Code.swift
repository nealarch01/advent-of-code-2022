import Foundation
import Darwin 


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
}

main()

