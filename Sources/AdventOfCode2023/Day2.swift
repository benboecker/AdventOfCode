//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 02.12.23.
//

import Foundation
import Utils


public struct Day2: Day {
	public init(_ input: Lines) {
		self.games = Self.loadGames(from: input)
	}
	
	private let games: [Game]
	private let config: (red: Int, green: Int, blue: Int) = (red: 12, green: 13, blue: 14)
	
	public func part1() async throws -> String {
		games.filter { game in
			game.draws.allSatisfy { draw in
				draw.red <= config.red && draw.green <= config.green && draw.blue <= config.blue
			}
		}
		.reduce(0) { $0 + $1.id }
		.formatted(.number.grouping(.never))
	}
	
	public func part2() async throws -> String {
		games
			.reduce(0) { $0 + $1.power }
			.formatted(.number.grouping(.never))
	}
}


private extension Day2 {
	static func loadGames(from lines: Lines) -> [Game] {
		lines.enumerated().compactMap { (index, line) in
			guard !line.isEmpty else { return nil }
			
			let draws = line
				.components(separatedBy: ":")[1]
				.components(separatedBy: ";")
				.map {
					let components = $0.components(separatedBy: ",")
					
					var red = 0
					var green = 0
					var blue = 0
					
					for component in components {
						let sep = component.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
						
						switch sep[1] {
						case "red": red = Int(sep[0]) ?? 0
						case "green": green = Int(sep[0]) ?? 0
						case "blue": blue = Int(sep[0]) ?? 0
						default: break
						}
					}
					
					return Draw(red: red, green: green, blue: blue)
				}
			
			return Game(id: index + 1, draws: draws)
		}
	}
}

fileprivate struct Draw {
	let red: Int
	let green: Int
	let blue: Int
}

fileprivate struct Game {
	let id: Int
	let draws: [Draw]
}

fileprivate extension Game {
	var power: Int {
		let maxRed = draws.max { $0.red < $1.red }?.red ?? 1
		let maxGreen = draws.max { $0.green < $1.green }?.green ?? 1
		let maxBlue = draws.max { $0.blue < $1.blue }?.blue ?? 1
		
		return maxRed * maxGreen * maxBlue
	}
}
