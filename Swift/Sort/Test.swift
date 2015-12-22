import Cocoa

//
//  Test.swift
//  Sort
//
//  Created by Paul Kraft on 13.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

class Test {
    init(rounds: Int, elements: Int, showResultsOfRound: Bool, showAllArrays: Bool, sortingAlgorithms: [([Number]->(String, [Number]))]) {
        if (elements < 1 || rounds < 1) { return }
		var unsorted : [Number] = []
		var s : [[(name: String, array: [Number], time: Double)]] = []
        for i in 1...rounds {
            unsorted = []
            let start = Double(NSDate().timeIntervalSince1970)
            for _ in 0..<elements {
                unsorted.append(Number())
            }
            let end : Double = Double(NSDate().timeIntervalSince1970)
            var round = "\(i)"
            while round.characters.count < "\(rounds)".characters.count {
                round = " " + round
            }
            print("round \(round) of \(rounds): \(stringWithThousandsPoint(unsorted.count)) elements")
            let a = self.compareSortingAlgorithms(unsorted, (end - start)*1000, showResultsOfRound, sortingAlgorithms)
            s.append(a)
            self.printComparedSortingAlgorithms(a, showAllArrays)
		}
		
        print("")
        var minAvgTime = Double.infinity
        var maxAvgTime = 0.0
        var minAvgTimeName = ""
        var maxAvgTimeName = ""
        var minAvgSwiftTime = Double.infinity
        var minAvgSwiftTimeName = ""
        var maxAvgSwiftTime = 0.0
        var maxAvgSwiftTimeName = ""
		for i in 0..<sortingAlgorithms.count+3 {
			var medianTime : Double = 0
			var times : Double = 0
			for j in 0..<s.count {
				medianTime += Double(s[j][i].time)
				times++
			}
            if i < 3 && i > 0 && minAvgSwiftTime > medianTime/times {
                minAvgSwiftTimeName = s[0][i].name
                minAvgSwiftTime = medianTime/times
            }
            if i < 3 && i > 0 && maxAvgSwiftTime < medianTime/times {
                maxAvgSwiftTimeName = s[0][i].name
                maxAvgSwiftTime = medianTime/times
            }
            if minAvgTime > medianTime/times && i > 2 {
                minAvgTimeName = s[0][i].name
                minAvgTime = medianTime/times
            }
            if maxAvgTime < medianTime/times && i > 2 {
                maxAvgTimeName = s[0][i].name
                maxAvgTime = medianTime/times
            }
            var avgTime = stringWithThousandsPoint(medianTime/times)
            for _ in 0...(12-avgTime.characters.count) {
                avgTime = " " + avgTime
            }
            var output = s[0][i].name + ":"
            while output.characters.count < 30 {
                output += " "
            }
            output += avgTime + " ms for " + stringWithThousandsPoint(s[0][i].array.count) + " elements."
			print(output)
            var separator = ""
            for _ in 0..<(output.characters.count) {
                separator += "-"
            }
            print(separator)
		}
        print("max time: " + maxAvgTimeName + ", min time: " + minAvgTimeName)
        if minAvgTime < minAvgSwiftTime {
            print("Yeah! The faster built-in algorithm " + minAvgSwiftTimeName + " was beaten by " + minAvgTimeName
                + "! (\(stringWithThousandsPoint(minAvgTime - minAvgSwiftTime)))")
        }
        if minAvgTime < maxAvgSwiftTime {
            print("Yeah! The slower built-in algorithm " + maxAvgSwiftTimeName + " was beaten by " + minAvgTimeName
                + "! (\(stringWithThousandsPoint(minAvgTime - minAvgSwiftTime)))")
        }
	}
    
    func compareSortingAlgorithms(unsorted: [Number], _ initTime: Double, _ showIndividualResults: Bool, _ sortingAlgorithms: [([Number]->(String, [Number]))]) -> [(name: String, array: [Number], time: Double)] {
		
        var all : [(name: String, array: [Number], time: Double)] = []
		
        all.append(("Creation(Array)", unsorted, initTime)) // adding creation time
        
        if showIndividualResults {
            print("\t\t\(all[0].name): \(stringWithThousandsPoint(all[0].time)) ms")
        }
        
        let start = NSDate()
        let s = unsorted.sort()
        let end = Double(NSDate().timeIntervalSinceDate(start))*1000
        all.append(("Sort(Swift)", s, end)) // adding swift-integrated-search
        
        if showIndividualResults {
            print("\t\t\(all[1].name): \(stringWithThousandsPoint(all[1].time)) ms")
        }
        
        var u = unsorted
        let start1 = NSDate()
        u.sortInPlace()
        let end1 = Double(NSDate().timeIntervalSinceDate(start1))*1000
        all.append(("SortInPlace(Swift)", u, end1))
        
        if showIndividualResults {
            print("\t\t\(all[2].name): \(stringWithThousandsPoint(all[2].time)) ms")
        }
        
		for i in 0..<sortingAlgorithms.count {
            let a = self.testAlg(sortingAlgorithms[i], unsorted)
            all.append((a.name, a.array, a.time))
            if showIndividualResults {
                print("\t\t\(a.name): \(stringWithThousandsPoint(a.time)) ms")
            }
		}
        if showIndividualResults { print("\n") }
		return all
	}
	
	func printComparedSortingAlgorithms(info: [(name: String, array: [Number], time: Double)], _ printAllOut: Bool) {
		for i in 0..<info.count {
			if printAllOut {
                print(info[i].name, "(", info[i].time, " ms )")
				for j in 0..<info[i].array.count { print(info[i].array[j].getValue()) }
                print("\n")
			}
			else
			{
				if(i > 0) {
					for j in 0..<info[i].array.count {
                        if(!(info[1].array[j] == info[i].array[j])) {
                            print(info[i].name, info[i].array[j].getValue())
                        }
                    }
				}
			}
		}
	}
    
    func stringWithThousandsPoint(number: Int) -> String {
        var anz = number
        var s = ""
        while anz >= 1000 {
            var a = "\(Int(anz % 1000))"
            while a.characters.count < 3 {
                a = "0" + a
            }
            s = ".\(a)\(s)"
            anz = anz/1000
        }
        return String(anz % 1000) + s
    }
    
    func stringWithThousandsPoint(number: Double, _ decimal: Int = 2) -> String {
        return stringWithThousandsPoint(Int(number)) + ","
                + (("\(number - Double(Int(number)))00000000" as NSString).substringFromIndex(2) as NSString).substringToIndex(decimal)
    }
	
	func testAlg(sort: (([Number]) -> (name: String, array: [Number])), _ unsorted: [Number]) -> (name: String, array: [Number], time: Double) {
		let start = NSDate()
        let sortResult = sort(unsorted)
        let end = Double(NSDate().timeIntervalSinceDate(start))*1000
        return (sortResult.name, sortResult.array, end)
	}
}
