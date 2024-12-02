//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 05.12.23.
//

import Foundation
import Utils


public struct Day7: Day {
	public init(_ input: Lines) {
		self.lines = input
	}
	
	let lines: Lines
	
	public func part1() async throws -> String {
		let hands = lines.filter { !$0.isEmpty }.map { Hand(from: $0) }
		let handsSorted = hands.sorted { $0 > $1}
		let bids = handsSorted.enumerated().map { (hands.count - $0) * $1.bid }
		let total = bids.reduce(0, +)
		
		return total
			.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		""
	}
	
}



private extension Day7 {
	struct Hand: Comparable {
		let cards: [Card]
		let handType: HandType
		let bid: Int
		
		init(from line: String) {
			let splitted = line.components(separatedBy: .whitespaces)
			self.cards = splitted[0].map { Card(from: $0) }
			self.handType = HandType(from: self.cards)
			self.bid = Int(splitted[1]) ?? 0
		}
		
		static func < (lhs: Day7.Hand, rhs: Day7.Hand) -> Bool {
			if lhs.handType == rhs.handType {
				for (index, card) in lhs.cards.enumerated() where card != rhs.cards[index] {
					return card < rhs.cards[index]
				}
				
				fatalError()
			} else {
				return lhs.handType < rhs.handType
			}
		}
	}
	
	enum HandType: Int, Comparable, Equatable {
		case fiveOfAKind = 100
		case fourOfAKind = 90
		case fullHouse = 80
		case threeOfAKind = 70
		case twoPair = 60
		case onePair = 50
		case highCard = 40
		
		init(from cards: [Card]) {
			let grouped = Dictionary(grouping: cards, by: { $0 })
			
			switch grouped.count {
			case 1: self = .fiveOfAKind // 22222
			case 2 where grouped.contains { $0.value.count == 3 }: self = .fullHouse // 222 33
			case 2: self = .fourOfAKind // 2222 3
			case 3 where grouped.contains { $0.value.count == 3 }: self = .threeOfAKind // 222 3 4
			case 3: self = .twoPair // 22 33 4
			case 4: self = .onePair // 11 2 3 4
			default: self = .highCard
			}
		}
		
		static func < (lhs: Day7.HandType, rhs: Day7.HandType) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
	}
	
	enum Card: Int, Comparable, Equatable {
		case ace = 14
		case king = 13
		case queen = 12
		case jack = 11
		case ten = 10
		case nine = 9
		case eight = 8
		case seven = 7
		case six = 6
		case five = 5
		case four = 4
		case three = 3
		case two = 2
		
		init(from value: Character) {
			switch value {
			case "A": self = .ace
			case "K": self = .king
			case "Q": self = .queen
			case "J": self = .jack
			case "T": self = .ten
			case "9": self = .nine
			case "8": self = .eight
			case "7": self = .seven
			case "6": self = .six
			case "5": self = .five
			case "4": self = .four
			case "3": self = .three
			case "2": self = .two
			default: fatalError()
			}
		}
		
		static func < (lhs: Day7.Card, rhs: Day7.Card) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
	}
}




public enum Day7_Part2 { }

public extension Day7_Part2 {
	static func part2(input: [String]? = nil) -> Int {
		let input = input ?? lines(in: "day7", bundle: .module)
		let hands = input.filter { !$0.isEmpty }.map { Hand(from: $0) }
		let handsSorted = hands.sorted { $0 > $1}
		let bids = handsSorted.enumerated().map { (hands.count - $0) * $1.bid }
		let total = bids.reduce(0, +)
		
		return total
	}
}

private extension Day7_Part2 {
	struct Hand: Comparable {
		let cards: [Card]
		let handType: HandType
		let bid: Int
		
		init(from line: String) {
			let splitted = line.components(separatedBy: .whitespaces)
			self.cards = splitted[0].map { Card(from: $0) }
			self.handType = HandType(from: self.cards)
			self.bid = Int(splitted[1]) ?? 0
		}
		
		static func < (lhs: Day7_Part2.Hand, rhs: Day7_Part2.Hand) -> Bool {
			if lhs.handType == rhs.handType {
				for (index, card) in lhs.cards.enumerated() where card != rhs.cards[index] {
					return card < rhs.cards[index]
				}
				
				fatalError()
			} else {
				return lhs.handType < rhs.handType
			}
		}
	}
	
	enum HandType: Int, Comparable, Equatable {
		case fiveOfAKind = 10
		case fourOfAKind = 9
		case fullHouse = 8
		case threeOfAKind = 7
		case twoPair = 6
		case onePair = 5
		case highCard = 4
		
		init(from cards: [Card]) {
			let jokerCount = cards.filter { $0 == .joker }.count
			let grouped = Dictionary(grouping: cards, by: { $0 })
			
			switch jokerCount {
			case 5: self = .fiveOfAKind // JJJJJ
			case 4 where grouped.count == 2: self = .fiveOfAKind // JJJJ 1
				
			case 3 where grouped.count == 2: self = .fiveOfAKind // JJJ 22
			case 3 where grouped.count == 3: self = .fourOfAKind // JJJ 2 3
				
			case 2 where grouped.count == 2: self = .fiveOfAKind // JJ 222
			case 2 where grouped.count == 3: self = .fourOfAKind // JJ 22 3
			case 2 where grouped.count == 4: self = .threeOfAKind // JJ 2 3 4

			case 1 where grouped.count == 2: self = .fiveOfAKind // J 2222
			case 1 where grouped.count == 3 && grouped.contains { $0.value.count == 3 }: self = .fourOfAKind // J 222 3
			case 1 where grouped.count == 3: self = .fullHouse // J 22 33
			case 1 where grouped.count == 4: self = .threeOfAKind // J 22 3 4
			case 1 where grouped.count == 5: self = .onePair // J 2 3 4 5
				
			default:
				switch grouped.count {
				case 1: self = .fiveOfAKind // 22222
				
				case 2 where grouped.contains { $0.value.count == 3 }: self = .fullHouse // 222 33
				case 2: self = .fourOfAKind // 2222 3
				
				case 3 where grouped.contains { $0.value.count == 3 }: self = .threeOfAKind // 222 3 4
				case 3: self = .twoPair // 22 33 4
				
				case 4: self = .onePair // 11 2 3 4
				
				default: self = .highCard
				}
			}
		}
		
		static func < (lhs: Day7_Part2.HandType, rhs: Day7_Part2.HandType) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
	}
	
	enum Card: Int, Comparable, Equatable {
		case ace = 14
		case king = 13
		case queen = 12
		case ten = 10
		case nine = 9
		case eight = 8
		case seven = 7
		case six = 6
		case five = 5
		case four = 4
		case three = 3
		case two = 2
		case joker = 1

		init(from value: Character) {
			switch value {
			case "A": self = .ace
			case "K": self = .king
			case "Q": self = .queen
			case "T": self = .ten
			case "9": self = .nine
			case "8": self = .eight
			case "7": self = .seven
			case "6": self = .six
			case "5": self = .five
			case "4": self = .four
			case "3": self = .three
			case "2": self = .two
			case "J": self = .joker
			default: fatalError()
			}
		}
		
		static func < (lhs: Day7_Part2.Card, rhs: Day7_Part2.Card) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
	}
}

