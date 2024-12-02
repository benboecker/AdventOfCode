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
			.count { $0.isSafe(usingProblemDampener: false) }
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		reports
			.count { $0.isSafe(usingProblemDampener: true) }
			.formatted(.number.grouping(.never))
	}
	
}


private extension Day2 {
	struct Report {
		init(_ string: String) {
			let splitted = string.components(separatedBy: " ")
			levels = splitted.compactMap { Int($0) }
		}
		
		let levels: [Int]
		
		func isSafe(usingProblemDampener: Bool) -> Bool {
			if usingProblemDampener {
				isSafeUsingProblemDampener
			} else {
				isSafe
			}
		}
		
		/// Solution for Part 1
		var isSafe: Bool {
			isDecreasing && neighborCheck
		}
		
		/// Solution for Part 2
		var isSafeUsingProblemDampener: Bool {
			true
		}
		
		var isDecreasing: Bool {
			for i in 1 ..< levels.count where levels[i] > levels[i - 1] {
				return false
			}
			
			return true
		}
		
		var isIncreasing: Bool {
			for i in 1 ..< levels.count where levels[i] < levels[i - 1] {
				return false
			}
			
			return true
		}
		
		var neighborCheck: Bool {
			for i in 1 ..< levels.count {
				let difference = abs(levels[i] - levels[i - 1])
				
				if difference > 3 || difference < 1{
					return false
				}
			}
			
			return true
		}
	}
	
}
