//
//  File.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 10.12.24.
//

import Foundation



public struct Grid<Element: Hashable> {
	private var size: Vector2D
	private var elements: [Element]
	
	public init(input: Lines, convert: (String) -> Element) {
		guard input.count > 0 else {
			self.size = .zero
			self.elements = []
			return
		}
		
		self.size = Vector2D(x: input.count, y: input[0].count)
		
//		var elements: [Element] = []
//		
//		for line in input {
//			elements += line.map { convert(String($0)) }
//		}
//		
//		self.elements = elements
		self.elements = input.reduce([]) { $0 + $1.map { convert(String($0)) } }
	}
	
	private init() {
		self.size = .zero
		self.elements = []
	}
}



public extension Grid {
	typealias PositionedElement = (position: Vector2D, element: Element)
	
	subscript(position: Vector2D) -> Element? {
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
			self[Vector2D(x, y)]
		}
		set {
			self[Vector2D(x, y)] = newValue
		}
	}
	
	func index(for position: Vector2D) -> Int? {
		guard position.isWithin(size) else {
			return nil
		}
		
		return position.y * size.width + position.x
	}
	
	func position(for index: Int) -> Vector2D? {
		guard
			index >= 0,
			index < size.width * size.height
		else {
			return nil
		}
		
		let qar = index.quotientAndRemainder(dividingBy: size.height)
		let y = qar.quotient
		let x = qar.remainder
		return Vector2D(x, y)
	}
	
	func position(in direction: Direction, from position: Vector2D) -> Vector2D? {
		let newPosition = switch direction {
		case .up:        position + Vector2D(0, -1)
		case .down:      position + Vector2D(0, 1)
		case .left:      position + Vector2D(-1, 0)
		case .right:     position + Vector2D(1, 0)
		case .upLeft:    position + Vector2D(-1, -1)
		case .upRight:   position + Vector2D(1, -1)
		case .downLeft:  position + Vector2D(-1, 1)
		case .downRight: position + Vector2D(1, 1)
		}
		
		if newPosition.isWithin(size) {
			return newPosition
		} else {
			return nil
		}
	}
	
	func element(in direction: Direction, from position: Vector2D) -> Element? {
		guard let newPosition = self.position(in: direction, from: position) else {
			return nil
		}
		
		return self[newPosition]
	}
	
	func neighbors(of position: Vector2D, includeDiagonal: Bool) -> [PositionedElement] {
		let directions: [Direction] = includeDiagonal ? Direction.all : Direction.nonDiagonal
		return directions.compactMap {
			guard
				let pos = self.position(in: $0, from: position),
				let element = self[pos]
			else {
				return nil
			}
			
			return (position: pos, element: element)
		}
	}
	
	func filter(_ predicate: (PositionedElement) -> Bool) -> [PositionedElement] {
		var results: [PositionedElement] = []
		
		for (index, element) in elements.enumerated() {
			guard let position = self.position(for: index) else { continue }
			
			if predicate((position: position, element: element)) {
				results.append((position: position, element: element))
			}
		}
		
		return results
	}
}

public extension Grid {
	enum Direction {
		case up, down, left, right
		case upLeft, upRight, downLeft, downRight
		
		var isDiagonal: Bool {
			switch self {
			case .upLeft, .upRight, .downLeft, .downRight: true
			default: false
			}
		}
		
		var isNotDiagonal: Bool { !isDiagonal }
		
		static var nonDiagonal: [Direction] {
			[.up, .down, .left, .right]
		}
		
		static var all: [Direction] {
			nonDiagonal + [.upLeft, .upRight, .downLeft, .downRight]
		}
	}
}


public extension Grid where Element == Bool {	
	mutating func toggle(at positions: Set<Vector2D>) {
		for position in positions {
			if let value = self[position] {
				self[position] = !value
			}
		}
	}
}
