//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public struct Day6: Day {
	public init(_ input: Lines) {
		self.map = Map(input: input)
	}
	
	private let map: Map
	
	public func part1() async throws -> String {
		var path: Set<Map.Position> = []
		
		var position: Map.Position? = map.guardPosition
		
		while position != nil {
			position = map.move(at: position)
			if let position {
				path.insert(position)
			}
		}
		
		return path.count.output
	}
	
	public func part2() async throws -> String {
		""
	}
}


private extension Day6 {
	class Map {
		typealias Size = (width: Int, height: Int)
		private var size: Size
		private var elements: [Element]
		
		init(input: Lines) {
			self.size = (width: input.count, height: input[0].count)
			
			var elements: [Element] = []
			
			for line in input {
				for element in line {
					switch element {
					case "#": elements.append(.obstacle)
					case "^": elements.append(.guard(direction: .up))
					default: elements.append(.empty)
					}
				}
			}
			
			self.elements = elements
		}
	}
}

private extension Day6.Map {
	subscript(position: Position) -> Element? {
		get {
			guard let index = index(for: position) else { return nil }
			return elements[index]
		}
		set {
			guard
				let index = index(for: position),
				let newValue
			else {
				return
			}
			
			elements[index] = newValue
		}
	}
	
	subscript(x: Int, y: Int) -> Element? {
		get {
			self[Position(x, y)]
		}
		set {
			self[Position(x, y)] = newValue
		}
	}
	
	func index(for position: Position) -> Int? {
		guard position.isWithinSize(size) else {
			return nil
		}
		
		return position.y * size.width + position.x
	}
	
	func position(for index: Int) -> Position? {
		guard
			index >= 0,
			index < size.width * size.height
		else {
			return nil
		}
		
		let qar = index.quotientAndRemainder(dividingBy: size.height)
		let y = qar.quotient
		let x = qar.remainder
		return Position(x, y)
	}
	
	var guardPosition: Position? {
		guard let index = elements.firstIndex(where: { $0.isGuard }) else { return nil }
		return position(for: index)
	}
	
	func move(at position: Position?) -> Position? {
		guard let position,
			  let element = self[position],
			  let direction = element.direction,
			  let nextPosition = moveElement(element, from: position, in: direction)
		else {
			return nil
		}
		
		return nextPosition
	}
	
	func moveElement(_ element: Element, from position: Position, in direction: Direction) -> Position? {
		guard
			let element = self[position],
			element.isMovable,
			let newPosition = positionByMoving(position, in: direction)
		else {
			return nil
		}
		
		if case let .guard(direction) = element,
		   let nextPostion = positionByMoving(newPosition, in: direction),
		   self[nextPostion] == .obstacle {
			self[newPosition] = .guard(direction: direction.turn)
		} else {
			self[newPosition] = element
		}
		
		self[position] = .empty

		return newPosition
	}
	
	func positionByMoving(_ start: Position, in direction: Direction) -> Position? {
		let newPosition = switch direction {
		case .up:    Position(start.x,     start.y - 1)
		case .right: Position(start.x + 1, start.y)
		case .down:  Position(start.x,     start.y + 1)
		case .left:  Position(start.x - 1, start.y)
		}
				
		return newPosition.isWithinSize(size) ? newPosition : nil
	}
	
	func printMap() {
//		for (index, element) in elements.enumerated() {
//			
//		}
	}
}

private extension Day6.Map {
	enum Element: Equatable {
		case empty
		case obstacle
		case `guard`(direction: Direction)
	}
	
	struct Position: Hashable {
		init(_ x: Int, _ y: Int) {
			self.x = x
			self.y = y
		}
		
		let x: Int
		let y: Int
	}
	
	enum Direction: Equatable {
		case up, right, down, left
	}
}

private extension Day6.Map.Position {
	func isWithinSize(_ size: Day6.Map.Size) -> Bool {
		x >= 0 && y >= 0 && x < size.width && y < size.height
	}
}

private extension Day6.Map.Element {
	var isMovable: Bool {
		switch self {
		case .empty, .obstacle: false
		case .guard: true
		}
	}
	
	var isGuard: Bool {
		if case .guard = self {
			return true
		} else {
			return false
		}
	}
	
	var direction: Day6.Map.Direction? {
		if case .guard(let direction) = self {
			return direction
		} else {
			return nil
		}
	}
}

private extension Day6.Map.Direction {
	var turn: Self {
		switch self {
		case .up: .right
		case .right: .down
		case .down: .left
		case .left: .up
		}
	}
}

