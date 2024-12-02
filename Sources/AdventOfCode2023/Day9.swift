//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public struct Day9: Day {
	public init(_ input: Utils.Lines) {
		self.lines = input
	}
	
	let lines: Lines
	typealias Map = [String: [String: String]]

	public func part1() async throws -> String {
		let values = lines
			.filter{ !$0.isEmpty }
			.map { Values(from: $0) }
		
		values.forEach { $0.calculatePrediction() }
		
		return values
			.reduce(0) { $0 + $1.predication }
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		let values = lines.filter{ !$0.isEmpty }.map { Values(from: $0) }
		
		values.forEach { $0.calculateHistory() }
		
		return values
			.reduce(0) { $0 + $1.history }
			.formatted(.number.grouping(.never))
	}
}


private extension Day9 {
	class Values {
		var sequences: [[Int]]
		var predication: Int { sequences.first?.last ?? 0 }
		var history: Int { sequences.first?.first ?? 0 }

		init(from line: String) {
			self.sequences = [line.components(separatedBy: .whitespaces).compactMap { Int($0) }]
		}
		
		func calculatePrediction() {
			addSequence()
			
			for i in 1 ..< sequences.count {
				let index = sequences.count - i
				
				sequences[index - 1].append(
					sequences[index - 1].last! + sequences[index].last!
				)				
			}
		}
		
		func calculateHistory() {
			addSequence()
			
			for i in 1 ..< sequences.count {
				let index = sequences.count - i
				
				sequences[index - 1].insert(
					sequences[index - 1].first! - sequences[index].first!,
					at: 0
				)
			}
		}
		
		func addSequence() {
			let lastSequence = sequences.last!
			var newSequence: [Int] = []
			for i in 1 ..< lastSequence.count {
				newSequence.append(lastSequence[i] - lastSequence[i - 1])
			}
			sequences.append(newSequence)
			
			if !newSequence.allSatisfy({ $0 == 0}) {
				addSequence()
			}
		}
	}
}

