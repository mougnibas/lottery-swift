// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation

/// Business app class.
public class AppBusiness {

    /// Random number generator to use.
    private var randomNumberGenerator: RandomNumberGenerator

    /// The declared grids.
    private var grids: [Grid]

    private var winningGrid: Grid?

    /// Initialize the class with a default random number generator.
    public init() {
        randomNumberGenerator = SystemRandomNumberGenerator()
        grids = []
    }

    public init(randomNumberGeneratorSeed: Int) {
        randomNumberGenerator = RandomNumberGeneratorWithSeed(seed: randomNumberGeneratorSeed)
        grids = []
    }

    /// Declare a grid to the current lottery.
    ///
    /// - Parameters:
    ///   - grid: A lottery grid to declare.
    public func declareGrid(grid: Grid) {
        grids.append(grid)
    }

    /// Reset the data to start a new draw (without reseting the RandomNumberGenerator).
    public func reset() {
        grids.removeAll()
        winningGrid = nil
    }

    /// Start a new draw (random sequence) then try to find a winning grid (if any),
    ///
    /// - Returns: The winning grid.
    public func draw() throws -> Grid {

        if winningGrid != nil {
            throw AppError.alreadyDrawn
        }

        // Create the random winning grid until it's a valid one
        var isValid: Bool = false
        repeat {

            // Create a random grid
            let value1: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value2: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value3: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value4: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let value5: Int = Int.random(in: 1...49, using: &randomNumberGenerator)
            let grid = Grid(value1, value2, value3, value4, value5)

            // Is it valid ?
            isValid = grid.isValid()

            // If it's valid, affect the current grid
            if isValid {
                winningGrid = Grid(value1, value2, value3, value4, value5)
            }

        } while !isValid

        // Return the result
        return winningGrid!
    }

    /// Is there a winner in the declared grid(s) ?
    ///
    /// - Returns: "true" if there is a declared winning grid, "false" otherwise.
    public func isThereAWinner() throws -> Bool {

        if winningGrid == nil {
            throw AppError.notDrawnYet
        }

        // The result holding the temporary winning statut
        var isThereAWinner: Bool = false

        // Try to find a winning grid
        for grid in grids where grid.getValues() == winningGrid!.getValues() {
            isThereAWinner = true
        }

        // Return the result
        return isThereAWinner
    }

    /// Some application error
    public enum AppError: Error {

        /// A draw already occured.
        case alreadyDrawn

        /// There was not a draw.
        case notDrawnYet

        /// This grid was already declared.
        case alreadyDeclared
    }
}
