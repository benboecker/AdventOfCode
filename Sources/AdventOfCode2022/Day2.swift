//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation
import Utils


public enum Day2 { }


public extension Day2 {
	static func part1() -> Int {
		getRounds(part1: true).reduce(0) { $0 + $1.points }
	}
	
	static func part2() -> Int {
		getRounds(part1: false).reduce(0) { $0 + $1.points }
	}
}

private extension Day2 {
	static func getRounds(part1: Bool) -> [Round] {
		lines(in: "day2", bundle: .module).filter{ !$0.isEmpty }.map { Round(from: $0, part1: part1) }
	}
}

private struct Round {
	let myShape: Shape
	let opponentShape: Shape
	
	init(from string: String, part1: Bool) {
		let parts = string.components(separatedBy: .whitespaces)
		
		self.opponentShape = Shape(from: parts[0])
		if part1 {
			self.myShape = Shape(from: parts[1])
		} else {
			let result = Result(from: parts[1])
			
			switch (opponentShape, result) {
			case (.rock, .win): self.myShape = .paper
			case (.rock, .draw): self.myShape = .rock
			case (.rock, .lose): self.myShape = .scissors
			case (.paper, .win): self.myShape = .scissors
			case (.paper, .draw): self.myShape = .paper
			case (.paper, .lose): self.myShape = .rock
			case (.scissors, .win): self.myShape = .rock
			case (.scissors, .draw): self.myShape = .scissors
			case (.scissors, .lose): self.myShape = .paper
			}
		}
	}
	
	enum Result: Int {
		case win = 6, draw = 3, lose = 0
		
		init(from string: String) {
			switch string {
			case "X": self = .lose
			case "Y": self = .draw
			case "Z": self = .win
			default: fatalError()
			}
		}
	}
	
	var result: Result {
		switch (myShape, opponentShape) {
		case (.rock, .rock): .draw
		case (.rock, .paper): .lose
		case (.rock, .scissors): .win
		case (.paper, .rock): .win
		case (.paper, .paper): .draw
		case (.paper, .scissors): .lose
		case (.scissors, .rock): .lose
		case (.scissors, .paper): .win
		case (.scissors, .scissors): .draw
		}
	}
	
	var points: Int {
		myShape.rawValue + result.rawValue
	}
}

private enum Shape: Int {
	case rock = 1, paper, scissors
	
	init(from string: String) {
		switch string {
		case "A", "X": self = .rock
		case "B", "Y": self = .paper
		case "C", "Z": self = .scissors
		default: fatalError()
		}
	}
}
