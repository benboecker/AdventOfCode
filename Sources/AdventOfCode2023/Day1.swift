//
//  File.swift
//
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation
import Utils



public struct Day1: Day {
	public init(_ input: Lines) {
		self.lines = input
	}
	
	let lines: Lines
	
	public func part1() async throws -> String {
		lines.reduce(0) { total, line in
			guard
				let firstNumber = line.first(where: { $0.isWholeNumber })?.wholeNumberValue,
				let lastNumber = line.last(where: { $0.isWholeNumber })?.wholeNumberValue
			else {
				return total
			}
			
			return total + firstNumber * 10 + lastNumber
		}
		.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		lines.reduce(0) { total, line in
			guard
				let firstNumber = line.firstNumber(),
				let lastNumber = line.lastNumber()
			else {
				return total
			}
			
			return total + firstNumber * 10 + lastNumber
		}.formatted(.number.grouping(.never))
	}
	
	
}


private extension String {
	private var numbers: [String: Int] { [
		"one": 1,
		"two": 2,
		"three": 3,
		"four": 4,
		"five": 5,
		"six": 6,
		"seven": 7,
		"eight": 8,
		"nine": 9,
		"1": 1,
		"2": 2,
		"3": 3,
		"4": 4,
		"5": 5,
		"6": 6,
		"7": 7,
		"8": 8,
		"9": 9,
	] }
	
	func firstNumber() -> Int? {
		var firstNumber = (0, Int.max)
		for number in numbers {
			guard let range = firstRange(of: number.key) else { continue }
			let index = range.lowerBound.utf16Offset(in: self)
			if index < firstNumber.1 {
				firstNumber = (number.value, index)
			}
		}

		return firstNumber.0
	}
	
	func lastNumber() -> Int? {
		var lastNumber = (0, Int.max)
		for number in numbers {
			guard let range = String(reversed()).firstRange(of: number.key.reversed()) else { continue }
			let index = range.lowerBound.utf16Offset(in: self)
			if index < lastNumber.1 {
				lastNumber = (number.value, index)
			}
		}

		return lastNumber.0
	}
}
