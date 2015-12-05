import Cocoa

// UseCase.swift
// Created by Paul Kraft on 04.12.15.

class UseCase
{
    init(_ rounds: Int, _ elements: Int)
	{
		var unsorted : [Number] = []
		var s : [[(name: String, array: [Number], time: Double)]] = []
        var anz = elements
        var elementsS = ""
        while anz >= 1000 {
            var a = "\(Int(anz % 1000))"
            while a.characters.count < 3 {
                a = "0" + a
            }
            elementsS = ".\(a)\(elementsS)"
            anz = Int(anz/1000)
        }
        elementsS = "\(Int(anz % 1000))" + elementsS
		for i in 1...rounds {
            print("round \(i) of \(rounds): \(elementsS) elements")
			let start = Double(NSDate().timeIntervalSince1970)
			for _ in 1...elements
			{
				unsorted.append(Number())
			}
			let end : Double = Double(NSDate().timeIntervalSince1970)
			let a = compareSortingAlgorithms(unsorted, (end - start)*1000, true)
			s.append(a)
			printComparedSortingAlgorithms(a, false)
		}
		
		for i in 0..<Sort<Number>().sortingAlgorithms.count+2 {
			var medianTime : Double = 0
			var times : Double = 0
			for j in 0..<s.count {
				medianTime += Double(s[j][i].time)
				times++
			}
            var output = s[0][i].name + ":"
            while output.characters.count < 26 {
                output += " "
            }
            for _ in 0...(10-String(Int(medianTime/times)).characters.count) {
                output += " "
            }
            output += String(Int(medianTime/times))
            output += " ms for " + String(s[0][i].array.count) + " elements."
			print(output)
            var separator = ""
            for _ in 0..<(output.characters.count) {
                separator += "-"
            }
            print(separator)
		}
		
	}
    
    func compareSortingAlgorithms(unsorted: [Number], _ initTime: Double, _ showIndividualResults: Bool) -> [(name: String, array: [Number], time: Double)] {
		var all : [(name: String, array: [Number], time: Double)] = []
		all.append(("Start", unsorted, initTime))
        var unsortedInt : [Int] = []
        for i in 0..<unsorted.count {
            unsortedInt.append(unsorted[i].description)
        }
        let start = NSDate()
        unsortedInt.sortInPlace()
        let end = Double(NSDate().timeIntervalSinceDate(start))*1000
        var unsortedNotInt : [Number] = []
        for i in 0..<unsortedInt.count {
            unsortedNotInt.append(Number(unsortedInt[i]))
        }
        all.append(("SortInPlace", unsortedNotInt, end))
        if showIndividualResults {
            print("\t\(all[1].name): \(Int(all[1].time)) ms", terminator: "")
        }
        
		for i in 0..<Sort<Number>().sortingAlgorithms.count {
            all.append( self.testAlg( (Sort<Number>()).sortingAlgorithms[i], unsorted))
            if showIndividualResults {
                print("\t\(all[i+2].name): \(Int(all[i+2].time)) ms", terminator: "")
            }
		}
        print("\n")
		return all
	}
	
	func printComparedSortingAlgorithms(info: [(name: String, array: [Number], time: Double)], _ printAllOut: Bool) {
		for i in 0..<info.count {
			//print(info[i].name, "(", info[i].time, " ms )")
			if printAllOut {
				for j in 0..<info[i].array.count { print(info[i].array[j].description) }
			}
			else
			{
				if(i > 0 && i < info.count) {
					for j in 0..<info[i].array.count {
						if(!(info[1].array[j].description == info[i].array[j].description)) {
							print(info[i].name, info[i].array[j].description)
						}
					}
				}
			}
		}
	}
	
	func testAlg(sort: (([Number]) -> (name: String, array: [Number])), _ unsorted: [Number]) -> (name: String, array: [Number], time: Double) {
		let start = NSDate()
        let sort = sort(unsorted)
		return (sort.name, sort.array, Double(NSDate().timeIntervalSinceDate(start))*1000)
	}
}
