//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public struct Day3: Day {
	public init(_ input: Lines) {
		self.grid = Grid(from: input)
	}
	
	private let grid: Grid
	
	public func part1() async throws -> String {
		var numbers: Set<Number> = []
		
		for (rowIndex, row) in grid.rows.enumerated() {
			for (columnIndex, character) in row.enumerated() {
				let position = Position(row: rowIndex, column: columnIndex)
				
				if let character, !character.isWholeNumber {
					let neighborPositions = grid.neighboringPositions(at: position)
					
					for neighborPosition in neighborPositions {
						if let number = grid.number(at: neighborPosition) {
							numbers.insert(number)
						}
					}
				}
			}
		}
		
		return numbers
			.reduce(0) { $0 + $1.value }
			.formatted(.number.grouping(.never))

	}
	
	public func part2() async throws -> String {
		var total = 0
		
		for (rowIndex, row) in grid.rows.enumerated() {
			for (columnIndex, character) in row.enumerated() {
				if let character, String(character) == "*" {
					let position = Position(row: rowIndex, column: columnIndex)
					
					let neighboringNumbers = Array(Set(
						grid
							.neighboringPositions(at: position)
							.compactMap { grid.number(at: $0) }
					))
					
					if neighboringNumbers.count == 2 {
						total += neighboringNumbers[0].value * neighboringNumbers[1].value
					}
				}
			}
		}
		
		return total
			.formatted(.number.grouping(.never))
	}
}

private extension Day3 {
	struct Grid: CustomStringConvertible {
		let rows: [[Character?]]
		
		init(from lines: Lines) {
			var rows: [[Character?]] = []
			
			for line in lines {
				var row: [Character?] = []
				for character in line {
					if String(character) == "." {
						row.append(nil)
					} else {
						row.append(character)
					}
				}
				rows.append(row)
			}
			
			self.rows = rows
		}
		
		func number(at position: Position) -> Number? {
			guard let char = character(at: position), char.isWholeNumber else {
				return nil
			}
			
			var numberString = String(char)
			var numberPositions: Set<Position> = [position]
			
			
			var newPosition = Position(row: position.row, column: position.column - 1)
			while let character = character(at: newPosition), character.isWholeNumber {
				numberString = "\(character)\(numberString)"
				numberPositions.insert(newPosition)
				newPosition = Position(row: newPosition.row, column: newPosition.column - 1)
			}

			newPosition = Position(row: position.row, column: position.column + 1)
			while let character = character(at: newPosition), character.isWholeNumber {
				numberString = "\(numberString)\(character)"
				numberPositions.insert(newPosition)
				newPosition = Position(row: newPosition.row, column: newPosition.column + 1)
			}

			
			if let numberValue = Int(numberString) {
				return Number(value: numberValue, positions: numberPositions)
			} else {
				return nil
			}
		}
		
		func character(at position: Position) -> Character? {
			guard
				let row = rows[safe: position.row],
				let char = row[safe: position.column], let char
			else {
				return nil
			}
			
			return char
		}
		
		func neighboringPositions(at position: Position) -> Set<Position> {
			var result = Set<Position>()
			
			result.insert(Position(row: position.row - 1, column: position.column - 1))
			result.insert(Position(row: position.row - 1, column: position.column))
			result.insert(Position(row: position.row - 1, column: position.column + 1))
			
			result.insert(Position(row: position.row, column: position.column - 1))
			result.insert(Position(row: position.row, column: position.column + 1))
			
			result.insert(Position(row: position.row + 1, column: position.column - 1))
			result.insert(Position(row: position.row + 1, column: position.column))
			result.insert(Position(row: position.row + 1, column: position.column + 1))
			
			return result
		}
		
		//func neighboringNumbers(at position: Position)
		
		var description: String {
			let rowDescriptions = rows.map { row in
				"" + row.map { String($0 ?? " ") }.joined(separator: "") + ""
			}
			
			return rowDescriptions.joined(separator: "\n")
		}
		
	}
	
	struct Position: Hashable {
		let row: Int
		let column: Int
	}
	
	struct Number: Hashable {
		let value: Int
		let positions: Set<Position>
	}
}
