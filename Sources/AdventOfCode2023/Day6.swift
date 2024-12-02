//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public struct Day6: Day {
	public init(_ input: Utils.Lines) {
		self.lines = input
	}
	
	let lines: Lines
	
	public func part1() async throws -> String {
		let races = zip(
			lines[0].components(separatedBy: ":")[1].components(separatedBy: .whitespaces).compactMap { Int($0) },
			lines[1].components(separatedBy: ":")[1].components(separatedBy: .whitespaces).compactMap { Int($0) }
		).map {
			Race(duration: $0, bestDistance: $1)
		}
		
		return races
			.reduce(1) { $0 * $1.distances.count }
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		let race = Race(
			duration: Int(lines[0].components(separatedBy: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0,
			bestDistance: Int(lines[1].components(separatedBy: ":")[1].replacingOccurrences(of: " ", with: "")) ?? 0
		)
		
		return race.distances.count.formatted(.number.grouping(.never))
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
