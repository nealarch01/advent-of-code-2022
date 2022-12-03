import Foundation
import Darwin 

/*
Opponent
A: Rock
B: Paper 
C: Scissors

Self (Part 1):
X: Rock
Y: Paper
Z: Scissors

Self (Part 2):
X: Lose
Y: Draw
Z: Win

Points for round
Rock: 1
Paper: 2
Scissors: 3

Additional
0 if lost 
3 if tie 
6 if win
*/

enum Result: Int {
    case win = 6
    case draw = 3
    case lose = 0
}

func rockPlayed(_ result: Result) -> Int {
    return 1 + result.rawValue
}

func paperPlayed(_ result: Result) -> Int {
    return 2 + result.rawValue
}

func scissorsPlayed(_ result: Result) -> Int {
    return 3 + result.rawValue
}

// Part One
func evaluateRoundP1(_ opponent: Character, _ pick: Character) -> Int {
    if opponent == "A" { // Opponent played rock
        switch pick {
            case "X": return rockPlayed(.draw)
            case "Y": return paperPlayed(.win)
            default: return scissorsPlayed(.lose) // Switch must be exhaustive
        }
    } else if opponent == "B" { // Opponent played paper
        switch pick {
            case "X": return rockPlayed(.lose)
            case "Y": return paperPlayed(.draw)
            default: return scissorsPlayed(.win)
        }
    } 
    // Opponent played scissors
    switch pick {
        case "X": return rockPlayed(.win)
        case "Y": return paperPlayed(.lose)
        default: return scissorsPlayed(.draw)
    }
}

// Part 2
func evaluateRoundP2(_ opponent: Character, _ pick: Character) -> Int {
    if opponent == "A" { // Opponent played rock
        switch pick {
            case "Z": return paperPlayed(.win)
            case "Y": return rockPlayed(.draw)
            default: return scissorsPlayed(.lose)
        }
    } else if opponent == "B" { // Opponent played paper
        switch pick {
            case "Z": return scissorsPlayed(.win)
            case "Y": return paperPlayed(.draw)
            default: return rockPlayed(.lose)
        }
    }
    // Opponent played scissors
    switch pick {
        case "Z": return rockPlayed(.win)
        case "Y": return scissorsPlayed(.draw)
        default: return paperPlayed(.lose)
    }
}

func calculateScore(rounds: [String]) -> (partOne: Int, partTwo: Int) {
    var scoreP1: Int = 0
    var scoreP2: Int = 0
    for round in rounds {
        if round == "" { // Last index is going to be an empty string
            break 
        }
        let firstIndex = round.index(round.startIndex, offsetBy: 0)
        let thirdIndex = round.index(round.startIndex, offsetBy: 2)
        let opponent = round[firstIndex]
        let pick = round[thirdIndex]
        scoreP1 += evaluateRoundP1(opponent, pick)
        scoreP2 += evaluateRoundP2(opponent, pick)
    }
    return (scoreP1, scoreP2)
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
    let rounds: [String] = contents.components(separatedBy: "\n")
    let score = calculateScore(rounds: rounds)
    print("Part one score: \(score.partOne)")
    print("Part two score: \(score.partTwo)")
    exit(0)
}

main()

