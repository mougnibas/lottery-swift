// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

/// Grid structure
public struct Grid: CustomStringConvertible, Equatable {

    /// Internal values data
    private var values: [Int]

    /// A "ToString()" equivalent in Swift.
    public var description: String {
        return "Grid[values=\(values)]"
    }

    /// Initialize the grid using all 6 values.
    ///
    /// - Parameters :
    ///   - value1: Value number 1.
    ///   - value2: Value number 2.
    ///   - value3: Value number 3.
    ///   - value4 : Value number 4.
    ///   - value5 : Value number 5.
    public init( _ value1: Int, _ value2: Int, _ value3: Int, _ value4: Int, _ value5: Int) {
        values = [value1, value2, value3, value4, value5]
    }

    /// Initialize a grid with random values.
    public init() {

        // Create a default system random number generator
        var randomNumberGenerator: RandomNumberGenerator = SystemRandomNumberGenerator()

        var grid: Grid?

        // Create the random winning grid until it's a valid one
        var isValid: Bool = false
        repeat {

            // Create a random grid
            let value1: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value2: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value3: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value4: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value5: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let currentGrid = Grid(value1, value2, value3, value4, value5)

            // Is it valid ?
            isValid = currentGrid.isValid()

            // If it's valid, affect the current grid
            if isValid {
                grid = currentGrid
            }

        } while !isValid

        // Affect a valid grid
        values = grid!.values
    }

    /// Initialize a grid with random values using a custom random number generator
    ///
    /// - Parameters :
    ///   - randomNumberGenerator : A random number generator to be used for randomness.
    public init(randomNumberGenerator: inout RandomNumberGenerator) {

        var grid: Grid?

        // Create the random winning grid until it's a valid one
        var isValid: Bool = false
        repeat {

            // Create a random grid
            let value1: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value2: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value3: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value4: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value5: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let currentGrid = Grid(value1, value2, value3, value4, value5)

            // Is it valid ?
            isValid = currentGrid.isValid()

            // If it's valid, affect the current grid
            if isValid {
                grid = currentGrid
            }

        } while !isValid

        // Affect a valid grid
        values = grid!.values
    }

    /// Get the values of the grid.
    ///
    /// - Returns : The values of the grid.
    public func getValues() -> [Int] {
        return values
    }

    /// Compute if the current grid contain valid values.
    ///
    /// - Returns : true if it's valid, false otherwise.
    public func isValid() -> Bool {

        let excluded0: [Int] = [ values[1], values[2], values[3], values[4] ]
        let excluded1: [Int] = [ values[0], values[2], values[3], values[4] ]
        let excluded2: [Int] = [ values[0], values[1], values[3], values[4] ]
        let excluded3: [Int] = [ values[0], values[1], values[2], values[4] ]
        let excluded4: [Int] = [ values[0], values[1], values[2], values[3] ]

        return !excluded0.contains(values[0]) &&
               !excluded1.contains(values[1]) &&
               !excluded2.contains(values[2]) &&
               !excluded3.contains(values[3]) &&
               !excluded4.contains(values[4])
    }
}
