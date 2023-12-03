//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public enum Day1 { }


public extension Day1 {
	static func part1() -> Int {
		let lines = lines(in: "day1", bundle: .module)
		
		var maxValue = 0
		var current = 0
		
		for line in lines {
			if line.isEmpty {
				maxValue = max(maxValue, current)
				current = 0
			} else {
				current += Int(line) ?? 0
			}
		}
		
		return maxValue
	}
	
	static func part2() -> Int {
		let lines = lines(in: "day1", bundle: .module)
		
		var calorieValues: [Int] = []
		var current = 0
		
		for line in lines {
			if line.isEmpty {
				calorieValues.append(current)
				current = 0
			} else {
				current += Int(line) ?? 0
			}
		}
		
		return calorieValues
			.sorted(using: KeyPathComparator(\.self, order: .reverse))
			.prefix(3)
			.reduce(0, +)
	}
}
