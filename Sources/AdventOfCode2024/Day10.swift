//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public class Day10: Day {
	public required init(_ input: Lines) {
		self.map = Grid(input: input) { char in
			Int(char)!
		}
	}
	
	let map: Grid<Int>
	
	public func part1() async throws -> String {
		let trailHeads = map.filter { _, element in
			element == 0
		}
		
		let result = trailHeads.reduce(0) { total, trailHead in
			let nines = nextPositions(for: trailHead.position)
				.uniqueElements
			return total + nines.count
		}
		
		return result.output
	}
	
	public func part2() async throws -> String {
		let trailHeads = map.filter { _, element in
			element == 0
		}
		
		let result = trailHeads.reduce(0) { total, trailHead in
			let nines = nextPositions(for: trailHead.position)
			return total + nines.count
		}
		
		return result.output
	}
}

private extension Day10 {
	func nextPositions(for position: Vector2D) -> [Vector2D] {
		guard let element = map[position] else { return [] }
		
		if element == 9 {
			return [position]
		}
		
		let possibleNeighbors = map
			.neighbors(of: position, includeDiagonal: false)
			.filter { _, neighbor in
				neighbor == element + 1
			}
			
		return possibleNeighbors.flatMap {
			nextPositions(for: $0.position)
		}
	}
}


