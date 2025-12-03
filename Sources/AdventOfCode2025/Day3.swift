//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 30.11.24.
//

import Foundation
import Utils


public struct Day3: Day {
	
	public init(_ input: Utils.Lines) {
		banks = input.map(BatteryBank.init)
	}

	private let banks: [BatteryBank]
	
	public func part1() async throws -> String {
		let joltages = banks.map { $0.maximumJoltage() }
		
		let result = joltages.reduce(0, +)
		
		return "\(result)"
	}
	
	public func part2() async throws -> String {
		let joltages = banks.map { $0.maximumJoltageWithLimit() }
		
		let result = joltages.reduce(0, +)
		
		return "\(result)"

	}
}

fileprivate struct BatteryBank {
	
	init(_ value: String) {
		batteries = value.compactMap { Int(String($0)) }
	}
	
	let batteries: [Int]
	
	func maximumJoltage() -> Int {
		/// first pass
		var firstDigit = 0
		
		for battery in batteries.dropLast() {
			firstDigit = max(firstDigit, battery)
		}
		
		guard let firstIndex = batteries.firstIndex(of: firstDigit)?.advanced(by: 1) else {
			fatalError()
		}
		
		
		/// second pass
		var secondDigit = 0
		for i in firstIndex ..< batteries.endIndex {
			secondDigit = max(secondDigit, batteries[i])
		}
		
		return Int("\(firstDigit)\(secondDigit)") ?? 0
	}
		
	func maximumJoltageWithLimit(_ limit: Int = 12) -> Int {
		
		var joltage = ""
		var batteriesCopy = batteries

		for pass in 1 ... limit {
			var digit = 0
			
			for i in 0 ..< batteriesCopy.endIndex - (limit - pass) {
				digit = max(digit, batteriesCopy[i])
			}
			
			let index = batteriesCopy.firstIndex(of: digit) ?? 0
			batteriesCopy.removeSubrange(0...index)
			
			joltage += "\(digit)"
		}
		
		return Int(joltage) ?? 0
	}
}
