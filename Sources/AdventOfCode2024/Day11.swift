//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public class Day11: Day {
	public required init(_ input: Lines) {
		self.stones = input[0].components(separatedBy: " ").compactMap { Int($0) }
	}
	
	private let stones: [Int]
	private let numberOfBlinks = (
		part1: 6,
		part2: 75
	)
	
	public func part1() async throws -> String {
		var stones = self.stones
		
		var index = 0
		
		while index < stones.count {
			for _ in 0 ..< numberOfBlinks.part1 {
				let value = stones[index]
				
				if value == 0 {
					stones[index] = 1
				} else if value.numberOfDigits.isEven {
					let splitted = value.splitted
					stones[index] = splitted[0]
					stones.insert(splitted[1], at: index + 1)
				} else {
					stones[index] = value * 2024
				}
			}
			
			index += 1
		}
		
		return stones.count.output
	}
	
	public func part2() async throws -> String {
		var stones = self.stones
		
		var index = 0
		
		while index < stones.count {
			for _ in 0 ..< numberOfBlinks.part2 {
				let value = stones[index]
				
				if value == 0 {
					stones[index] = 1
				} else if value.numberOfDigits.isEven {
					let splitted = value.splitted
					stones[index] = splitted[0]
					stones.insert(splitted[1], at: index + 1)
				} else {
					stones[index] = value * 2024
				}
			}
			
			index += 1
		}
		
		return stones.count.output
	}
}

private extension Int {
	func applyRules() -> [Int] {
		if self == 0 {
			return [1]
		} else if numberOfDigits.isEven {
			return splitted
		} else {
			return [self * 2024]
		}
	}
	
	var numberOfDigits: Int {
		"\(self)".count
	}
	
	var splitted: [Int] {
		let value = "\(self)"
		
		guard
			let first = Int(value.prefix(value.count / 2)),
			let last = Int(value.suffix(value.count / 2))
		else {
			return []
		}
		
		return [first, last]
	}
	
	var isEven: Bool {
		isMultiple(of: 2)
	}
	
	var isOdd: Bool {
		!isEven
	}
}

private extension [Int] {
	func applyRules() -> [Int] {
		var result: [Int] = []
		
		for i in 0 ..< count {
			let value = self[0]
			if value == 0 {
				result.append(1)
			} else if value.numberOfDigits.isEven {
				result.append(value)
			} else {
				result.append(value * 2024)
			}
		}
		
		return result
	}
}


