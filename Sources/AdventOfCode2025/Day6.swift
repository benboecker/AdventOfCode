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
		
		let v = input.map {
			$0.map(String.init)
		}
		
		let t = v.transposed()
		var currentValues: [Int] = []
		var currentOperation = Problem.Operation.add
		
		func createProblem() {
			guard currentValues.hasContent else { return }
			let problem = Problem(numbers: currentValues, operation: currentOperation)
			currentValues = []
			problemsPart2.append(problem)
		}
		
		for elements in t {
			if elements.contains("+") {
				createProblem()
				currentOperation = .add
				let numberString = elements.dropLast().joined().trimmingCharacters(in: .whitespaces)
				let number = Int(numberString) ?? 0
				currentValues.append(number)

			} else if elements.contains("*") {
				createProblem()
				currentOperation = .multiply
				let numberString = elements.dropLast().joined().trimmingCharacters(in: .whitespaces)
				let number = Int(numberString) ?? 0
				currentValues.append(number)
			} else {
				let numberString = elements.joined().trimmingCharacters(in: .whitespaces)
				guard numberString.hasContent else { continue }
				let number = Int(numberString) ?? 0
				currentValues.append(number)
			}
		}
		
		createProblem()
	}

	private var problems: [Problem] = []
	private var problemsPart2: [Problem] = []


	public func part1() async throws -> String {
		let result = problems.reduce(0) {
			$0 + $1.solution
		}

		return "\(result)"
	}
	
	
	public func part2() async throws -> String {
		let result = problemsPart2.reduce(0) {
			$0 + $1.solution
		}
		
		return "\(result)"
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
