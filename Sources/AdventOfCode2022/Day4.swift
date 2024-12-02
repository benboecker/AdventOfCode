//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils



public struct Day4: Day {
	let lines: Lines
	
	public init(_ input: Utils.Lines) {
		self.lines = input
	}
	
	public func part1() async throws -> String {
		lines.count { line in
			let splitted = line.split(separator: ",")
			guard splitted.count == 2 else { return false }
			
			let left = IDRange(from: String(splitted[0]))
			let right = IDRange(from: String(splitted[1]))
			
			return left.contains(right) || right.contains(left)
		}
		.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		lines.count { line in
			let splitted = line.split(separator: ",")
			guard splitted.count == 2 else { return false }
			
			let left = IDRange(from: String(splitted[0]))
			let right = IDRange(from: String(splitted[1]))
			
			return left.overlaps(right)
		}
		.formatted(.number.grouping(.never))
	}
	
	
	
}


fileprivate struct IDRange: Equatable {
	init(from string: String) {
		let splitted = string.components(separatedBy: "-")
		
		self.indexSet = IndexSet(Int(splitted[0])! ... Int(splitted[1])!)
	}
	
	let indexSet: IndexSet
	
	func contains(_ range: IDRange) -> Bool {
		range.indexSet.isSubset(of: indexSet)
	}
	
	func overlaps(_ range: IDRange) -> Bool {
		!range.indexSet.intersection(indexSet).isEmpty
	}
}
