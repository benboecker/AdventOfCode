//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public enum Day8 { }

public extension Day8 {
	typealias Map = [String: [String: String]]
	
	static func part1(input: [String]? = nil) -> Int {
		let lines = input ?? lines(in: "day8", bundle: .module)
		
		let instructions = lines[0].map { String($0) }
		let map = getMap(from: lines)
		
		var currentLocation = "AAA"
		var instructionIndex = 0
		var stepCount = 0
		
		while currentLocation != "ZZZ" {
			let nextDirection = instructions[instructionIndex]

			guard
				let options = map[currentLocation],
				let nextDestination = options[nextDirection]
			else { fatalError("fuck... '\(currentLocation)' not found in map") }
						
			currentLocation = nextDestination
			stepCount += 1
			
			instructionIndex = instructionIndex < instructions.count - 1 ? instructionIndex + 1 : 0
		}
		
		return stepCount
	}
	
	static func part2(input: [String]? = nil) -> Int {
		let lines = input ?? lines(in: "day8", bundle: .module)
		
		let instructions = lines[0].map { String($0) }
		let map = getMap(from: lines)

		var instructionIndex = 0
		var currentLocations = map.keys.filter(\.isStart)
		var stepCounts = Array(repeating: 0, count: currentLocations.count)
		var stepCount = 1
		
		while !stepCounts.allSatisfy({ $0 > 0 }) {
			let nextDirection = instructions[instructionIndex]
			
			for (index, location) in currentLocations.enumerated() {
				let nextDestination = map[location]![nextDirection]!
				currentLocations[index] = nextDestination
				
				if nextDestination.isEnd {
					stepCounts[index] = stepCount
				}
			}
			
			stepCount += 1
			instructionIndex = instructionIndex < instructions.count - 1 ? instructionIndex + 1 : 0
		}
		
		return stepCounts.leastCommonMultiple
	}

}

private extension Day8 {
	static func getMap(from lines: [String]) -> Map {
		var map: Map = [:]
		
		for line in lines where !line.isEmpty {
			let splitted = line.components(separatedBy: " = ")
			guard splitted.count == 2 else { continue }
			let destinations = splitted[1]
				.replacingOccurrences(of: "(", with: "")
				.replacingOccurrences(of: ")", with: "")
				.components(separatedBy: ", ")
			
			map[splitted[0]] = [
				"L": destinations[0],
				"R": destinations[1],
			]
		}
		
		return map
	}
}

private extension String {
	var isStart: Bool {
		last == "A"
	}
	var isEnd: Bool {
		last == "Z"
	}
}


private extension Array where Element == Int {
	var leastCommonMultiple: Int {
		if isEmpty {
			return 0
		}

		var result = self[0]

		for i in 1 ..< count {
			result = lcm(result, self[i])
		}

		return result
	}
}

private func gcd(_ x: Int, _ y: Int) -> Int {
	var a = x
	var b = y
	while b != 0 {
		let temp = b
		b = a % b
		a = temp
	}
	return abs(a)
}

private func lcm(_ x: Int, _ y: Int) -> Int {
	guard x != 0, y != 0 else { return 0 }
	return abs(x * y) / gcd(x, y)
}

