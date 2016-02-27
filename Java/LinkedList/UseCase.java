package LinkedList;
import java.util.*;

class UseCase {
	public static void main(String[] args) {
		LinkedList<Nummer> n = new LinkedList<Nummer>();
		for(int i = 0; i < 5000; i++) {
			n.add(new Nummer());
		}
		new QuickSortThreaded<Nummer>(n, System.currentTimeMillis()).start();
		
		/*
		for(int i = 0; i < n.size(); i++) {
			System.out.println(n.get(i).toString());
		}
		*/
	}
}