//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 04.12.23.
//

import Foundation

import Utils


public struct Day4: Day {
	
	public init(_ input: Utils.Lines) {
		self.lines = input
	}
	
	let lines: Lines
	
	public func part1() async throws -> String {
		lines
			.filter { !$0.isEmpty }
			.reduce(0) { total, line in
				let splitted = line.components(separatedBy: ":")[1].components(separatedBy: "|")
				let matchingNumbersCount = Set(splitted[0].components(separatedBy: .whitespaces).compactMap { Int($0) })
					.intersection(
						Set(splitted[1].components(separatedBy: .whitespaces).compactMap { Int($0) })
					).count
				
				if matchingNumbersCount > 0 {
					return total + (pow(2, matchingNumbersCount - 1) as NSDecimalNumber).intValue
				} else {
					return total
				}
			}
			.formatted(.number.grouping(.never))

	}
	
	public func part2() async throws -> String {
		typealias Card = (matching: Int, copies: Int)
		
		var cards = lines
			.filter { !$0.isEmpty }
			.map { line in
				let splitted = line.components(separatedBy: ":")[1].components(separatedBy: "|")
				let myNumbers = Set(splitted[1].components(separatedBy: .whitespaces).compactMap { Int($0) })
				let winningNumbers = Set(splitted[0].components(separatedBy: .whitespaces).compactMap { Int($0) })
				let intersect = winningNumbers.intersection(myNumbers)
				return (matching: intersect.count, copies: 1)
			}
		
		for index in (0 ..< cards.count) {
			let card = cards[index]
			for _ in (0 ..< card.copies) where card.matching > 0 {
				for i in (index + 1 ... index + card.matching) where i < cards.count {
					let copyCard = cards[i]
					cards[i] = (matching: copyCard.matching, copies: copyCard.copies + 1)
				}
			}
		}
		
		return cards
			.reduce(0) { $0 + $1.copies }
			.formatted(.number.grouping(.never))
	}
}
