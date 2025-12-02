//
//  Day4.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 04.12.24.
//

import Foundation
import Utils
import RegexBuilder

public struct Day4: Day {
	public init(_ input: Lines) {
		self.puzzle = Puzzle(lines: input)
	}
	
	private let puzzle: Puzzle
	
	public func part1() async throws -> String {
		puzzle.countWord("XMAS").output
	}
	
	public func part2() async throws -> String {
		puzzle.countXMas.output
	}
	
}


private extension Day4 {
	struct Puzzle {
		init(lines: Lines) {
			self.rows = lines.map { $0 }
		}
		
		private let rows: [String]
	}
}

private extension Day4.Puzzle {
	var size: (width: Int, height: Int) {
		(width: rows[0].count, height: rows.count)
	}
	
	subscript(row: Int, column: Int) -> String {
		guard row >= 0, column >= 0, row < size.height, column < size.width else {
			return ""
		}
		
		return rows[row][column]
	}
	
	var countXMas: Int {
		var result = 0
		
		for row in (1 ..< size.height - 1) {
			for column in (1 ..< size.width - 1) where self[row, column] == "A" {
				let topLeft = self[row - 1, column - 1]
				let topRight = self[row - 1, column + 1]
				let bottomLeft = self[row + 1, column - 1]
				let bottomRight = self[row + 1, column + 1]
				
				
				switch (topLeft, bottomRight, bottomLeft, topRight) {
				case ("M", "S", "S", "M"):
					result += 1
				case ("S", "M", "S", "M"):
					result += 1
				case ("M", "S", "M", "S"):
					result += 1
				case ("S", "M", "M", "S"):
					result += 1
				default: break
				}
			}
		}
		
		return result
	}
	
	func countWord(_ word: String) -> Int {
		let horizontal = rows.reduce(0) { total, next in
			total + next.countWord(word) + String(next.reversed()).countWord(word)
		}
		let vertical = columns.reduce(0) { total, next in
			total + next.countWord(word) + String(next.reversed()).countWord(word)
		}
		
		let diagonalsForwardCount = diagonalsForward.reduce(0) { total, next in
			total + next.countWord(word) + String(next.reversed()).countWord(word)
		}
		
		let diagonalsBackwardCount = diagonalsBackward.reduce(0) { total, next in
			total + next.countWord(word) + String(next.reversed()).countWord(word)
		}
		
		return horizontal + vertical + diagonalsForwardCount + diagonalsBackwardCount
	}
	
	var columns: [String] {
		rows[0].indices.map { col in
			String(rows.indices.map { row in
				rows[row][col]
			})
		}
	}
	
	var diagonalsForward: [String] {
		(0 ..< size.height).map { row in
			diagonalSubstring(at: (row: row, column: 0), forward: true)
		}.reversed()
		+
		(1 ..< size.width).map { column in
			diagonalSubstring(at: (row: 0, column: column), forward: true)
		}
	}
	
	var diagonalsBackward: [String] {
		(0 ..< size.width).map { column in
			diagonalSubstring(at: (row: 0, column: column), forward: false)
		}
		+
		(1 ..< size.height).map { row in
			diagonalSubstring(at: (row: row, column: size.width - 1), forward: false)
		}
	}
	
	func diagonalSubstring(at position: (row: Int, column: Int), forward: Bool) -> String {
		var result = ""
		var row = position.row
		var column = position.column
		
		while row < size.height, column < size.width, column >= 0 {
			result += self[row, column]
			row += 1
			column += forward ? 1 : -1
		}
				
		return result
	}
}

private extension String {
	func countWord(_ word: String) -> Int {
		guard word.count <= count else { return 0 }
		return matches(of: word).count
	}
}

private extension [String] {
}
