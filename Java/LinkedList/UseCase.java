package SortingAlgs;
import java.util.*;

class UseCase {
	public static void main(String[] args) {
		LinkedList<Number> n = new LinkedList<Number>();
		for(int i = 0; i < 500000; i++) {
			n.add(new Number());
		}
		long start = System.currentTimeMillis();
		LinkedList<Number> qs = (new QuickSortThreaded<Number>(n)).sort(n);
		System.out.println("QuickSortThreaded: " + (System.currentTimeMillis() - start) + " ms");
		
		
		/*
		for(int i = 0; i < n.size(); i++) {
			System.out.println(n.get(i).toString());
		}
		*/
	}
}