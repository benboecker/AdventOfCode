//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day4: Day {
	
	public init(_ input: Utils.Lines) {
		grid = Grid(input: input) { element in
			element == "@"
		}
	}

	private var grid: Grid<Bool>
	
	public func part1() async throws -> String {
		"\(grid.accessibleElements().count)"
	}
	
	public func part2() async throws -> String {
		var grid = self.grid
		
		var removed = 0
		var removable = grid.accessibleElements()
		
		while removable.hasContent {
			removed += removable.count
			grid.toggle(at: removable)
			removable = grid.accessibleElements()
		}
		
		return "\(removed)"
	}
}


fileprivate extension Grid where Element == Bool {
	
	func accessibleElements() -> Set<Vector2D> {
		filter { element in
			guard element.element else { return false }
			
			return self
				.neighbors(of: element.position, includeDiagonal: true)
				.filter { element in
					element.element
				}
				.count < 4
		}
		.map(\.position)
		.toSet()
	}
		
}
