//
//  File.swift
//
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation


public enum Day1 { }

public extension Day1 {
	static func part1() -> Int {
		lines(in: "day1").reduce(0) { total, line in
			guard
				let firstNumber = line.first(where: { $0.isWholeNumber })?.wholeNumberValue,
				let lastNumber = line.last(where: { $0.isWholeNumber })?.wholeNumberValue
			else {
				return total
			}
			
			return total + firstNumber * 10 + lastNumber
		}
	}
	
	static func part2() -> Int {
		lines(in: "day1").reduce(0) { total, line in
			guard
				let firstNumber = line.firstNumber(),
				let lastNumber = line.lastNumber()
			else {
				return total
			}

			return total + firstNumber * 10 + lastNumber
		}
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
