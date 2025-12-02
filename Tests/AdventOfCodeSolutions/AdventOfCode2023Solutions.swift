import Testing
import AdventOfCode2023
import Utils


@Suite("Advent of Code 2023 - Solutions")
struct AdventOfCode2023Solutions {
	
	@Test("Solutions")
	func solutions() async throws {
		let days: [any Day] = [
//			Day1(Lines(fileName: "2023-01", bundle: .module)),
//			Day2(Lines(fileName: "2023-02", bundle: .module)),
//			Day3(Lines(fileName: "2023-03", bundle: .module)),
//			Day4(Lines(fileName: "2023-04", bundle: .module)),
//			Day5(Lines(fileName: "2023-05", bundle: .module)),
//			Day6(Lines(fileName: "2023-06", bundle: .module)),
//			Day4(Lines(fileName: "2023-07", bundle: .module)),
//			Day5(Lines(fileName: "2023-08", bundle: .module)),
//			Day6(Lines(fileName: "2023-09", bundle: .module)),
		]
		
		for (index, day) in days.enumerated() {
			try await day.printDay(index)
		}
		
		print("")
	}
}
