// GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
// Everyone is permitted to copy and distribute verbatim copies
// of this license document, but changing it is not allowed.

import Foundation
import XCTest
@testable import LotteryCore

/// Unit tests of "Grid" class.
final class GridTests: XCTestCase {

    /// Test that a grid is valid.
    func testThisIsValidGrid() throws {

        // Arrange
        let grid: Grid = Grid(45, 18, 43, 21, 11)
        let expected: Bool = true

        // Act
        let actual: Bool = grid.isValid()

        // Assert
        XCTAssertEqual(expected, actual)

    }

    /// Test that a grid is NOT valid.
    func testThisIsNotValidGrid() throws {

        // Arrange
        let grid: Grid = Grid(45, 45, 43, 21, 11)
        let expected: Bool = false

        // Act
        let actual: Bool = grid.isValid()

        // Assert
        XCTAssertEqual(expected, actual)

    }

    /// Test the "Description" getter.
    func testDescription() throws {

        // Arrange
        let grid: Grid = Grid(45, 18, 43, 21, 10)
        let expected: String = "Grid[values=[45, 18, 43, 21, 10]]"

        // Act
        let actual: String = grid.description

        // Assert
        XCTAssertEqual(expected, actual)
    }

    /// Test the internal values of this grid.
    func testInternalValues() throws {

        // Arrange
        let grid: Grid = Grid(45, 18, 43, 21, 10)
        let expected: [Int] = [45, 18, 43, 21, 10]

        // Act
        let actual: [Int] = grid.getValues()

        // Assert
        XCTAssertEqual(expected, actual)
    }

    func testThatTwoSameGridsAreEquals() throws {

        // Arrange
        let grid1: Grid = Grid(45, 18, 43, 21, 10)
        let grid2: Grid = Grid(45, 18, 43, 21, 10)

        // Act and Assert
        XCTAssertEqual(grid1, grid2)
    }

    func testThatTwoDifferentGridsAreNotEquals() throws {

        // Arrange
        let grid1: Grid = Grid(45, 18, 43, 21, 10)
        let grid2: Grid = Grid(45, 18, 43, 21, 11)

        // Act and Assert
        XCTAssertNotEqual(grid1, grid2)
    }

    func testThatOneFixedGridAndARandomGrisAreNtEquals() throws {

        // Arrange
        let grid1: Grid = Grid(45, 18, 43, 21, 10)
        let grid2: Grid = Grid()

        // Act and Assert
        XCTAssertNotEqual(grid1, grid2)
    }
}
