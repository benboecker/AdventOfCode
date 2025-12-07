//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day5: Day {
	
	public init(_ input: Utils.Lines) {
		let splitted = input.split(separator: "")

		for rangeLine in splitted[0] {
			let bounds = rangeLine.split(separator: "-").compactMap { Int(String($0)) }
			let range = bounds[0] ... bounds[1]
			
			multiRange.insert(range)
		}
		
		self.ingredients = splitted[1].compactMap { Int(String($0)) }
		
	}

	
	private var multiRange = MultiRange()
	let ingredients: [Int]
	

	public func part1() async throws -> String {
		let result = ingredients.count { ingredient in
			multiRange.contains(ingredient)
		}
		
		return "\(result)"
	}
	
	public func part2() async throws -> String {
		"\(multiRange.totalCount)"
	}
}


extension ClosedRange {
	
	func union(with range: ClosedRange<Bound>) -> ClosedRange<Bound>? {
		guard overlaps(range) else { return nil }
		
		return Swift.min(lowerBound, range.lowerBound) ... Swift.max(upperBound, range.upperBound)
	}
	
}

struct MultiRange {
	/// Invariant: `ranges` is always sorted, non-overlapping, and non-adjacent.
	private(set) var ranges: [ClosedRange<Int>] = []
	
	init() {}
	init(_ ranges: [ClosedRange<Int>]) {
		self.ranges = ranges
		normalize()
	}
	
	var totalCount: Int {
		ranges.reduce(0) { $0 + $1.count }
	}
	
	mutating func insert(_ newRange: ClosedRange<Int>) {
		guard !ranges.isEmpty else {
			ranges = [newRange]
			return
		}
		
		ranges.append(newRange)
		normalize()
	}
	
	func contains(_ value: Int) -> Bool {
		// Binary search would be nicer, but linear is fine if small.
		for r in ranges where r.contains(value) {
			return true
		}
		return false
	}
}

extension MultiRange {
	/// Sorts and merges overlapping or adjacent ranges so that `ranges`
	/// is sorted, non-overlapping, and non-adjacent.
	mutating func normalize() {
		guard !ranges.isEmpty else { return }
		
		// 1. Sort by lower bound
		ranges.sort { $0.lowerBound < $1.lowerBound }
		
		// 2. Merge
		var result: [ClosedRange<Int>] = []
		result.reserveCapacity(ranges.count)
		
		var current = ranges[0]
		
		for range in ranges.dropFirst() {
			// Overlap or adjacency?
			//  r.lower <= current.upper + 1  → overlap or directly touching (e.g. 5...10 and 11...20)
			if range.lowerBound <= current.upperBound + 1 {
				// merge them
				current = current.lowerBound ... max(current.upperBound, range.upperBound)
			} else {
				// gap: push current and start new
				result.append(current)
				current = range
			}
		}
		
		result.append(current)
		ranges = result
	}
}
