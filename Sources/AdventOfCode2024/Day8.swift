//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public struct Day8: Day {
	public init(_ input: Lines) {
		self.lines = input
	}

	private let lines: Lines
	
	public func part1() async throws -> String {
		var positions: [String: [Vector2D]] = [:]
		let size: Size = (width: lines[0].count, height: lines.count)
		
		for (row, line) in lines.enumerated() {
			for (column, element) in line.enumerated() where element != "." {
				positions[String(element), default: []].append(Vector2D(x: column, y: row))
			}
		}
		
		var anitnodePositions: Set<Vector2D> = []
		for (_, positions) in positions {
			for position in positions {
				let frequencyAntinodePositions = positions
					.filter { $0 != position }
					.compactMap { position2 in
						let diff = position2 - position
						let anti = position - diff
											
						if anti.isWithin(size) {
							return anti
						} else {
							return nil
						}
					}
				
				for frequencyAntinodePosition in frequencyAntinodePositions {
					anitnodePositions.insert(frequencyAntinodePosition)
				}
			}
		}
		
		return anitnodePositions.count.output
	}
	
	public func part2() async throws -> String {
		var positions: [String: [Vector2D]] = [:]
		let size = (width: lines[0].count, height: lines.count)
		
		for (row, line) in lines.enumerated() {
			for (column, element) in line.enumerated() where element != "." {
				positions[String(element), default: []].append(Vector2D(x: column, y: row))
			}
		}
		
		var anitnodePositions: Set<Vector2D> = []
		for (_, positions) in positions {
			for position in positions {
				let frequencyAntinodePositions = positions
					.filter { $0 != position }
					.map { position2 in
						let diff = position2 - position
						var anti = position - diff
						var antis: [Vector2D] = []
						
						while anti.isWithin(size) {
							antis.append(anti)
							anti = anti - diff
						}

						anti = position + diff
						while anti.isWithin(size) {
							antis.append(anti)
							anti = anti + diff
						}

						return antis
					}
					.flatMap { $0 }
				
				for frequencyAntinodePosition in frequencyAntinodePositions {
					anitnodePositions.insert(frequencyAntinodePosition)
				}
			}
		}
		
		return anitnodePositions.count.output
	}
}

typealias Size = (width: Int, height: Int)

extension Vector2D {
	func isWithin(_ size: Size) -> Bool {
		x >= 0 && y >= 0 && x < size.width && y < size.height
	}
}
