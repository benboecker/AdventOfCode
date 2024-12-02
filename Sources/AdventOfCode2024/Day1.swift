//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day1: Day {
	public init(_ input: Lines) {
		self.leftList = input.map { line in
			let splitted = line.components(separatedBy: "   ")
			return Int(splitted[0])!
		}
		
		self.rightList = input.map { line in
			let splitted = line.components(separatedBy: "   ")
			return Int(splitted[1])!
		}
		
		assert(leftList.count == rightList.count, "the two lists must have the same number of entries")
	}
	
	private let leftList: [Int]
	private let rightList: [Int]

	public func part1() async throws -> String {
		let leftList = leftList.sorted()
		let rightList = rightList.sorted()
				
		var distance = 0
		for index in 0 ..< leftList.count {
			let left = leftList[index]
			let right = rightList[index]
			distance += max(left, right) - min(left, right)
		}
		
		return distance.formatted(.number)
	}
	
	public func part2() async throws -> String {
		var simmilarityScore = 0
		
		for entry in leftList {
			let multiply = rightList.count { $0 == entry }
			simmilarityScore += entry * multiply
		}
		
		return simmilarityScore.formatted(.number)
	}
	
}
