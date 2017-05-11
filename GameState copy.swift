//
//  GameState.swift
//  Mastermind
//
//  Created by TJ Usiyan on 2017/01/20.
//  Copyright © 2017 Buttons and Lights LLC. All rights reserved.
//

enum State {
    case inProgress([Code])
}//This will presumably indicate the progress of the game, but is not used anywhere else

public struct Code : ExpressibleByArrayLiteral {
    var value: [Color]
    var length: Int {
        return value.count
    }

    public init(_ value: [Color]) {
        self.value = value
    }

    public init(_ values: Color...) {
        self.init(values)
    }

    public init(arrayLiteral elements: Color...) {
        self.init(elements)
    }
}//This is the struct that holds mastermind's four-color peg code. It can be initialized from an array of type color, or from an array literal

extension Code : Equatable {
    public static func ==(lhs:Code, rhs:Code) -> Bool {
        return lhs.value == rhs.value
    }
}//Makes Code equatable

extension Code {
    public struct Feedback : Equatable {
        let perfect: Int
        let imperfect: Int

        internal init(perfect: Int = 0, imperfect: Int = 0) {
            self.perfect = perfect
            self.imperfect = imperfect
        }

        internal init(guess: Code, answer: Code) throws {
            guard guess.value.count == answer.value.count else { throw Error.unequalCodeLength }

            let perfect = zip(guess.value, answer.value).reduce(0) {
                ($1.0 == $1.1) ? $0 + 1 : $0//This method of generating the 'pefect' value will return an Int equal to the total number of cases where the Colors in guess and answer match in the same order because they will appear together in a tuple.
            }
            let imperfect = Set(guess.value).intersection(Set(answer.value)).count - perfect //this will get the number of times the colors match and remove any cases where they also appear in the same order - the 'imperfect' guesses of right color but wrong place

            self.init(perfect: perfect, imperfect: imperfect)
        }

        static func array(_ guesses: [Code], answer: Code) throws -> [Feedback] {
            return try guesses.flatMap { guess in
                try Feedback(guess: guess, answer: answer)
            }
        }//This generates an array of Feedback instances by comparing an array of "guess" codes to the answer code.

        public static func ==(lhs:Feedback, rhs:Feedback) -> Bool {
            return lhs.perfect == rhs.perfect && lhs.imperfect == rhs.imperfect
        }

        enum Error : Swift.Error {
            case unequalCodeLength
        }
    }
}//Code now contains an equatable type 'Feedback'.  This seems to be for comparing user input codes against an answer code and returning the equivalent of black and white 'key' pegs.  This is not yet implemented when the app runs.



public enum ColorSet {
    case standard

    var colors: Set<Color> {
        switch self {
        case .standard:
            return [
                .red,
                .orange,
                .yellow,
                .green,
                .blue,
                .purple,
                .magenta,
                .lightGrey
            ]
        }
    }
}//Conveniently stores all cases of the Color enum in a set.

public enum Color : Hashable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case magenta
    case lightGrey
}
