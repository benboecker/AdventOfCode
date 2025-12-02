//
//  Day6.swift
//  AdventOfCode
//
//  Created by Benjamin Böcker on 06.12.24.
//

import Foundation
import Utils
import RegexBuilder


public class Day23: Day {
	public required init(_ input: Lines) {
		connections = Set(input.map(Connection.init))
	}
	
	let connections: Set<Connection>
	
	public func part1() async throws -> String {
		var networks: Set<Connection> = []
		
		for (index, connection) in connections.enumerated() {
			if index % 100 == 0 {
				print("Done: \(index)")
			}
			for secondConnection in connections {
				guard secondConnection != connection,
					  connection.connects(to: secondConnection)
				else {
					continue
				}
				
				for thirdConnection in connections {
					guard
						thirdConnection != secondConnection,
						thirdConnection != connection,
						connection.connects(to: thirdConnection),
						secondConnection.connects(to: thirdConnection)
					else {
						continue
					}
					
					let finalConnection = connection
						.connect(to: secondConnection)
						.connect(to: thirdConnection)
					
					if finalConnection.computers.count == 3, finalConnection.isT {
						networks.insert(finalConnection)
					}
				}
			}
		}
		
		return "\(networks.count)"
	}
	
	public func part2() async throws -> String {
		var networks: Set<Connection> = [connections.first!]
		
		for connection in connections {
			for network in networks {
				if connection.connects(to: network) {
					networks.insert(connection.connect(to: network))
				}
			}
		}
		
		let password = networks
			.sorted { $0.computers.count > $1.computers.count }
			.first!
			.computers
			.sorted()
			.joined(separator: ",")
		
		return password
	}
}



struct Connection: Equatable, Hashable, Comparable {
	static func < (lhs: Connection, rhs: Connection) -> Bool {
		lhs.computers.count < rhs.computers.count
	}
	
	init(input: String) {
		let splitted = input.split(separator: "-")
		self.computers = [String(splitted[0]), String(splitted[1])]
	}
	
	private init(computers: Set<String>) {
		self.computers = computers
	}
	
	let computers: Set<String>
	
	func connects(to connection: Connection) -> Bool {
		computers.intersection(connection.computers).count == 1
	}
	
	func connect(to connection: Connection) -> Connection {
		Connection(computers: computers.union(connection.computers))
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(computers)
	}
	
	var isT: Bool {
		computers.contains { $0.starts(with: "t") }
	}
}



