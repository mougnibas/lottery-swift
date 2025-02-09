// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import XCTest
@testable import LotteryCore

/// Unit tests of "LotteryCore" class.
final class LotteryCoreTests: XCTestCase {

    /// Test a winning grid.
    func testThisWinningGrid() throws {

        // Arrange
        let seed: Int = 12345
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        let grid: Grid = Grid(45, 18, 43, 21, 10)
        appBusiness.declareGrid(grid: grid)
        _ = try appBusiness.draw()
        let expected: Bool = true

        // Act
        let actual: Bool = try appBusiness.isThereAWinner()

        // Assert
        XCTAssertEqual(actual, expected)
    }

    /// Test a loosing grid.
    func testThisLoosingGrid() throws {

        // Arrange
        let seed: Int = 12345
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        let grid: Grid = Grid(45, 18, 43, 21, 11)
        appBusiness.declareGrid(grid: grid)
        _ = try appBusiness.draw()
        let expected: Bool = false

        // Act
        let actual: Bool = try appBusiness.isThereAWinner()

        // Assert
        XCTAssertEqual(actual, expected)
    }

    /// Test a loosing grid without a seed.
    func testThisLoosingGridWithoutSeed() throws {

        // Arrange
        let appBusiness = AppBusiness()
        let grid: Grid = Grid(45, 18, 43, 21, 11)
        appBusiness.declareGrid(grid: grid)
        _ = try appBusiness.draw()
        let expected: Bool = false

        // Act
        let actual: Bool = try appBusiness.isThereAWinner()

        // Assert
        XCTAssertEqual(actual, expected)
    }

    /// Test that two call to Draw will throw an error.
    func testThisThrowErrorWhenDrawingCalledTwoTimes() throws {

        // Arrange
        let seed: Int = 12345
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        _ = try appBusiness.draw()

        // Act and Assert
        XCTAssertThrowsError(try appBusiness.draw())
    }

    func testThisThrowErrorWhenCallingIsThereAWinnerWithoutDrawingFirst() throws {

        // Arrange
        let seed: Int = 12345
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)

        // Act and Assert
        XCTAssertThrowsError(try appBusiness.isThereAWinner())
    }

    func testThatOneMillionTryIsNotEnough() throws {

        // Arrange
        let seed: Int = 12345
        let grid: Grid = Grid(45, 18, 43, 21, 11)
        let expected: Bool = false
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        let max: Int = 1_000_000

        // Act
        var actual: Bool = false
        var counter: Int = 0
        repeat {
            appBusiness.declareGrid(grid: grid)
            _ = try appBusiness.draw()
            actual = try appBusiness.isThereAWinner()
            appBusiness.reset()
            counter += 1
        } while (counter <= max && !actual)

        // Assert
        XCTAssertEqual(actual, expected)
    }

    func testThat1MGridIsNotEnoughToWin() throws {

        // Arrange
        let seed: Int = 12345
        var rng: RandomNumberGenerator = RandomNumberGeneratorWithSeed(seed: 678906757947905474)
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        let max: Int = 1_000_000
        for _ in 1...max {
            let currentGrid: Grid = Grid(randomNumberGenerator: &rng)
            appBusiness.declareGrid(grid: currentGrid)
        }
        _ = try appBusiness.draw()

        // Act
        let actual: Bool = try appBusiness.isThereAWinner()

        // Assert
        XCTAssertFalse(actual)
    }

    func testThat1MLoosingGridsAndASingleWinningGridIsEnoughToWin() throws {

        // Arrange
        let winningGrid: Grid = Grid(43, 21, 27, 12, 10)
        let seed: Int = 12345
        var rng: RandomNumberGenerator = RandomNumberGeneratorWithSeed(seed: 67890)
        let appBusiness = AppBusiness(randomNumberGeneratorSeed: seed)
        let max: Int = 1_000_000
        for _ in 1...max {
            let currentGrid: Grid = Grid(randomNumberGenerator: &rng)
            appBusiness.declareGrid(grid: currentGrid)
        }
        appBusiness.declareGrid(grid: winningGrid)
        _ = try appBusiness.draw()

        // Act
        let actual: Bool = try appBusiness.isThereAWinner()

        // Assert
        XCTAssertTrue(actual)
    }
}
