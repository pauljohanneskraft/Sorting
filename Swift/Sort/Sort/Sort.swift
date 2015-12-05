import Cocoa

// Sort
// Created by Paul Kraft on 03.12.15.

class Sort<T : CompareElement>
{
	var sortingAlgorithms : [([T] -> (String, [T]))] = []
    let MAX_THREADS = 12
    var threadCount = 1
	init()
	{
		sortingAlgorithms = [
			//bubbleSort,
			//insertionSort,
			quickSort,
			quickSortRandom,
            quickSortMedian,
			quickSortThreaded,
            quickSortRandomThreaded,
            quickSortMedianThreaded,
            quickSortArray
		]
	}
	
	func insertionSort(unsorted: [T]) -> (String, [T]) {
		var sorted : [T] = []
		for i in 0..<unsorted.count {
			sorted.append(unsorted[i]);
		}
		for i in 0..<sorted.count {
			var k = 0
			while(k < i && sorted[k] < sorted[i]) { k++ }
			sorted.insert(sorted.removeAtIndex(i), atIndex: k)
		}
		return ("InsertionSort", sorted)
	}
	
	func quickSort(unsorted: [T]) -> (name: String, array: [T]) {
		var l : [T] = []
		var r : [T] = []
		if unsorted.count > 0 {
			let pivot = unsorted[0]
			for i in 1..<unsorted.count {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			r = self.quickSort(r).array
			l = self.quickSort(l).array
			l.append(pivot)
		}
		return ("QuickSort", l + r)
	}
	
	func quickSortThreaded(unsorted: [T]) -> (name: String, array: [T]) {
		return ("QuickSortThreaded", quickSortThreadedRecursive(unsorted))
	}
	
	private func quickSortThreadedRecursive(unsorted: [T]) -> [T]
	{
		if unsorted.count == 0 { return [] }
		var l : [T] = []
		var r : [T] = []
		let pivot = unsorted[0]
		for i in 1..<unsorted.count {
			if unsorted[i] < pivot { l.append(unsorted[i]) }
			else { r.append(unsorted[i]) }
		}
		if threadCount + 2 < MAX_THREADS {
            threadCount += 2
			let group = dispatch_group_create();
			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				r = self.quickSortThreadedRecursive(r)
			});

			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				l = self.quickSortThreadedRecursive(l)
			});
			
			dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            threadCount -= 2
		}
		else {
			r = self.quickSortThreadedRecursive(r)
			l = self.quickSortThreadedRecursive(l)
		}
		l.append(pivot)
		return l + r
	}

	
	func quickSortRandom(unsorted: [T]) -> (name: String, array: [T]) {
		var l : [T] = []
		var r : [T] = []
		if unsorted.count > 0 {
			let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
			let pivot = unsorted[pivotIndex]
			for i in 0..<pivotIndex {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			for i in pivotIndex+1..<unsorted.count {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else { r.append(unsorted[i]) }
			}
			r = self.quickSortRandom(r).array
			l = self.quickSortRandom(l).array
			l.append(pivot)
		}
		return ("QuickSortRandom", l + r)
	}
    
    
    func quickSortMedian(unsorted: [T]) -> (name: String, array: [T]) {
        var l : [T] = []
        var r : [T] = []
        if unsorted.count > 0 {
            let pivotIndex = unsorted.count/2
            let pivot = unsorted[pivotIndex]
            for i in 0..<pivotIndex {
                if unsorted[i] < pivot { l.append(unsorted[i]) }
                else { r.append(unsorted[i]) }
            }
            for i in pivotIndex+1..<unsorted.count {
                if unsorted[i] < pivot { l.append(unsorted[i]) }
                else { r.append(unsorted[i]) }
            }
            r = self.quickSortRandom(r).array
            l = self.quickSortRandom(l).array
            l.append(pivot)
        }
        return ("QuickSortMedian", l + r)
    }

	
	func quickSortRandomThreaded(unsorted: [T]) -> (name: String, array: [T]) {
		return ("QuickSortRandomThreaded", quickSortRandomThreadedRecursive(unsorted))
	}
	
	private func quickSortRandomThreadedRecursive(unsorted: [T]) -> [T] {
		if unsorted.count == 0 { return [] }
		var l : [T] = []
		var r : [T] = []
        let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
		let pivot = unsorted[pivotIndex]
		for i in 0..<unsorted.count {
			if (i != pivotIndex) {
				if unsorted[i] < pivot { l.append(unsorted[i]) }
				else                   { r.append(unsorted[i]) }
			}
		}
		if threadCount + 2 < MAX_THREADS {
            threadCount += 2
			let group = dispatch_group_create();
			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				r = self.quickSortRandomThreadedRecursive(r)
			});

			dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
				l = self.quickSortRandomThreadedRecursive(l)
			});
			dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            threadCount -= 2
		}
		else
		{
			r = self.quickSortRandomThreadedRecursive(r)
			l = self.quickSortRandomThreadedRecursive(l)
		}
		l.append(pivot)
		return l + r
	}
    
    func quickSortMedianThreaded(unsorted: [T]) -> (name: String, array: [T]) {
        return ("QuickSortMedianThreaded", quickSortMedianThreadedRecursive(unsorted, 0))
    }
    
    private func quickSortMedianThreadedRecursive(unsorted: [T]) -> [T] {
        if unsorted.count == 0 { return [] }
        var l : [T] = []
        var r : [T] = []
        let pivotIndex = unsorted.count/2
        let pivot = unsorted[pivotIndex]
        for i in 0..<unsorted.count {
            if (i != pivotIndex) {
                if unsorted[i] < pivot { l.append(unsorted[i]) }
                else                   { r.append(unsorted[i]) }
            }
        }
        if threadCount + 2 < MAX_THREADS {
            threadCount += 2
            let group = dispatch_group_create();
            dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                r = self.quickSortMedianThreadedRecursive(r)
            });
            
            dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                l = self.quickSortMedianThreadedRecursive(l)
            });
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            threadCount -= 2
        }
        else
        {
            r = self.quickSortMedianThreadedRecursive(r)
            l = self.quickSortMedianThreadedRecursive(l)
        }
        l.append(pivot)
        return l + r
    }

	
    func quickSortArray(unsorted: [T]) -> (name: String, array: [T]) {
        var sorted : [T] = []
        for i in 0..<unsorted.count {
            sorted.append(unsorted[i])
        }
        sorted = quickSortArrayRecursive(sorted, 0, sorted.count - 1)
        return ("QuickSortArray", sorted)
    }
    
    private func quickSortArrayRecursive(var sorted: [T], _ start : Int, _ end: Int) -> [T]
    {
        if end > start {
            let pivot : Int
            (sorted, pivot) = quickSortArrayPartition(sorted, start, end)
            sorted = self.quickSortArrayRecursive(sorted, start, pivot - 1)
            sorted = self.quickSortArrayRecursive(sorted, pivot + 1, end)
        }
        return sorted
    }
    
    private func quickSortArrayPartition(var sorted: [T], _ start : Int, _ end: Int) -> (array: [T], pivot: Int)
    {
        var i = start
        for j in (start + 1)...end {
            if sorted[j] < sorted[start] {
                i++
                (sorted[i], sorted[j]) = (sorted[j], sorted[i])
            }
        }
        (sorted[i], sorted[start]) = (sorted[start], sorted[i])
        return (sorted, i)
    }
    
    func bubbleSort(unsorted: [T]) -> (String, [T])
	{
		var sorted : [T] = []
		for i in 0..<unsorted.count{
			sorted.append(unsorted[i]);
		}
		var didChange = false
		repeat
		{
			didChange = false
			for i in 0..<sorted.count - 1 {
				if sorted[i+1] < sorted[i] {
					didChange = true
					sorted.insert(sorted.removeAtIndex(i+1), atIndex: i);
				}
			}
		}
			while(didChange)
		return ("BubbleSort", sorted)
	}
	
}
