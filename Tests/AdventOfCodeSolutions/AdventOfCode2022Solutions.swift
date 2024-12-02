import Testing
import AdventOfCode2022
import Utils


@Suite("Advent of Code 2022 - Solutions")
struct AdventOfCode2022Solutions {
	
	@Test("Solutions")
	func solutions() async throws {
		let days: [any Day] = [
			Day1(Lines(fileName: "2022-01", bundle: .module)),
			Day2(Lines(fileName: "2022-02", bundle: .module)),
			Day3(Lines(fileName: "2022-03", bundle: .module)),
			Day4(Lines(fileName: "2022-04", bundle: .module)),
			Day5(Lines(fileName: "2022-05", bundle: .module)),
			Day6(Lines(fileName: "2022-06", bundle: .module)),
		]
		
		for (index, day) in days.enumerated() {
			try await day.printDay(index)
		}
		
		print("")
	}
}
