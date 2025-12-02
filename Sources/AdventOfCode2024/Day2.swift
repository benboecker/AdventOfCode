//
//  Day2.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day2: Day {
	public init(_ input: Lines) {
		reports = input.map { Report($0) }
	}
	
	private let reports: [Report]
	
	public func part1() async throws -> String {
		reports
			.count { $0.isSafe }
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		reports
			.count { $0.isSafeUsingProblemDampener }
			.formatted(.number.grouping(.never))
	}
	
}


private extension Day2 {
	struct Report {
		init(_ string: String) {
			let splitted = string.components(separatedBy: " ")
			levels = splitted.compactMap { Int($0) }
		}
		
		private var levels: [Int]
				
		var isSafe: Bool {
			levels.isSafe
		}
		
		var isSafeUsingProblemDampener: Bool {
			guard !isSafe else {
				return true
			}
			
			for i in 0 ..< levels.count {
				let dampenedLevels = levels.drop(at: i)
				if dampenedLevels.isSafe {
					return true
				}
			}
			
			return false
		}
	}
}


private extension [Int] {
	var isSafe: Bool {
		(isDecreasing || isIncreasing) && neighborCheck
	}
	
	var isDecreasing: Bool {
		for i in 1 ..< self.count where self[i] > self[i - 1] {
			return false
		}
		
		return true
	}
	
	var isIncreasing: Bool {
		for i in 1 ..< self.count where self[i] < self[i - 1] {
			return false
		}
		
		return true
	}
	
	var neighborCheck: Bool {
		for i in 1 ..< self.count {
			let difference = abs(self[i] - self[i - 1])
			
			if difference > 3 || difference < 1{
				return false
			}
		}
		
		return true
	}
}


private extension Array {
	func drop(at index: Index) -> Array<Element> {
		self.enumerated()
			.filter {
				$0.offset != index
			}
			.map(\.element)
	}
}
