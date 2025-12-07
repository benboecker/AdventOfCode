//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 03.12.23.
//

import Foundation

public extension Array {
	subscript(safe index: Int) -> Element? {
		guard index >= 0, index < count else {
			return nil
		}
		
		return self[index]
	}
}

public extension Collection {
	var hasContent: Bool { !isEmpty }
}

public extension Collection where Element: Hashable {
	var uniqueElements: [Element] {
		Array(Set(self))
	}
	
	func toSet() -> Set<Element> {
		Set(self)
	}
}

public extension Array where Element: RandomAccessCollection {
	func transposed() -> [[Element.Element]] {
		guard let firstRow = self.first else { return [] }
		return firstRow.indices.map { columnIndex in
			self.map { $0[columnIndex] }
		}
	}
}
