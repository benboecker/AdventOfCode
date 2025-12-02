//
//  Day4.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 04.12.24.
//

import Foundation
import Utils
import RegexBuilder

public struct Day5: Day {
	public init(_ input: Lines) {
		let parsed = Self.parseInput(input)
		self.pageRules = parsed.0
		self.updates = parsed.1
	}
	
	private let pageRules: PageRules
	private let updates: [Update]
	
	public func part1() async throws -> String {
		updates
			.filter { $0.isCorrect(applying: pageRules) }
			.middleNumberSum
			.output
	}
	
	public func part2() async throws -> String {
		updates
			.filter { !$0.isCorrect(applying: pageRules) }
			.map { $0.correctOrder(applying: pageRules) }
			.middleNumberSum
			.output
	}
}


private extension Day5 {

	static func parseInput(_ input: Lines) -> (PageRules, [Update]) {
		let splitted = input.split(separator: "")
		let rules = PageRules(Array(splitted[0]))
		let updates = splitted[1].map(Update.init)
		
		return (rules, updates)
	}
	
	struct PageRules {
		let numbers: [Int: Set<Int>]
		
		init(_ input: [String]) {
			var numbers: [Int: Set<Int>] = [:]
			
			let pairs = input.map {
				$0.components(separatedBy: "|").compactMap(Int.init)
			}
			
			for pair in pairs {
				numbers[pair[0], default: []].insert(pair[1])
			}
			
			self.numbers = numbers
		}
		
		subscript(page: Int) -> Set<Int> {
			numbers[page] ?? []
		}
	}
	
	struct Update {
		private init(_ pages: [Int]) {
			self.pages = pages
		}
		
		init(_ input: String) {
			pages = input.components(separatedBy: ",").compactMap(Int.init)
		}
		
		let pages: [Int]
		
		var middleNumber: Int {
			pages[pages.count / 2]
		}
		
		func isCorrect(applying pageRules: PageRules) -> Bool {
			pages.wrongNumbers(applying: pageRules).isEmpty
		}
		
		func correctOrder(applying rules: PageRules) -> Update {
			let wrongNumbers = pages.wrongNumbers(applying: rules)
			if wrongNumbers.isEmpty {
				return self
			}
			
			var result = pages

			for wrongNumber in wrongNumbers {
				guard
					let wrongNumberIndex = result.firstIndex(of: wrongNumber.wrongNumber),
					let violatedIndex = result.firstIndex(of: wrongNumber.violated)
				else { return self }
				
				result.swapAt(wrongNumberIndex, violatedIndex)
			}
			
			return Update(result).correctOrder(applying: rules)
		}
	}
}

private extension [Day5.Update] {
	var middleNumberSum: Int {
		reduce(0) { total, update in
			total + update.middleNumber
		}
	}
}

private extension [Int] {
	func wrongNumbers(applying rules: Day5.PageRules) -> [(wrongNumber: Int, violated: Int)] {
		enumerated()
			.compactMap { index, number in
				let rules = rules[number]
				let before = Set(prefix(upTo: index))
				
				let intersection = rules.intersection(before)
				if let violated = intersection.first {
					return (wrongNumber: number, violated: violated)
				} else {
					return nil
				}
			}
	}
}
