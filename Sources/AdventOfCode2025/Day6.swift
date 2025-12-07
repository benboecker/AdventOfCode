//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day6: Day {
	
	public init(_ input: Utils.Lines) {
		var values: [[String]] = []
		
		values = input.map {
			$0.split(separator: " ").map(String.init)
		}
		.transposed()
		
		self.problems = values.map {
			let numbers = $0.dropLast().compactMap(Int.init)
			let operation: Problem.Operation = $0.last == "+" ? .add : .multiply
			return Problem(numbers: numbers, operation: operation)
		}
	}

	private var problems: [Problem] = []
	

	public func part1() async throws -> String {
		let result = problems.reduce(0) {
			$0 + $1.solution
		}

		return "\(result)"
	}
	
	
	public func part2() async throws -> String {
		""
	}
}


fileprivate struct Problem {
	enum Operation {
		case add, multiply
	}
	
	var numbers: [Int] = []
	var operation: Operation = .add
	
	var solution: Int {
		if operation == .add {
			return numbers.reduce(0, +)
		} else {
			return numbers.reduce(1, *)
		}
	}
	
}
