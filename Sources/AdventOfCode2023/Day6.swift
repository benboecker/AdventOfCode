//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public enum Day6 { }

public extension Day6 {
	static func part1(input: [String]? = nil) -> Int {
		let input = input ?? lines(in: "day6", bundle: .module)
		let races = zip(
			input[0].components(separatedBy: ":")[1].components(separatedBy: .whitespaces).compactMap { Int($0) },
			input[1].components(separatedBy: ":")[1].components(separatedBy: .whitespaces).compactMap { Int($0) }
		).map {
			Race(duration: $0, bestDistance: $1)
		}
		
		return races.reduce(1) { $0 * $1.distances.count }
	}
	
	static func part2(input: [String]? = nil) -> Int {
		let input = input ?? lines(in: "day6", bundle: .module)
		let race = Race(
			duration: Int(input[0].components(separatedBy: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0,
			bestDistance: Int(input[1].components(separatedBy: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0
		)
		
		return race.distances.count
	}
}




private extension Day6 {
	struct Race: Hashable {
		let duration: Int
		let bestDistance: Int
		
		func getDistance(for charge: Int) -> Int {
			(duration - charge) * charge
		}
		
		var distances: [Int] {
			(1 ..< duration)
				.map { getDistance(for: $0) }
				.filter { $0 > bestDistance }
		}
	}
}
