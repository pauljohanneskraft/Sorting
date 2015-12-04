package SortingAlgs;
import java.util.*;

class QuickSortThreaded<T> extends Sort<T> {
	private static final int MAX_THREADS = 2;
	private static int countThreads = 0;
	private LinkedList<T> liste;
	public QuickSortThreaded(LinkedList<T> liste)
	{
		countThreads++;
		this.liste = liste;
	}
	
	public void run()
	{
		sort(liste);
	}
	
	<T> LinkedList<T> sort(LinkedList<T> liste) {
		LinkedList<T> right = new LinkedList<T>();
		LinkedList<T> left = new LinkedList<T>();
		if(liste.size() > 0) 
		{
			int p = (new Random()).nextInt(liste.size());
			T pivot = liste.get(p);
			for(int i = 0; i < p; i++) {
				if(pivot.toString().compareTo(liste.get(i).toString()) > 0) left.add(liste.get(i));
				else right.add(liste.get(i));
			}
			for(int i = p + 1; i < liste.size(); i++) {
				if(pivot.toString().compareTo(liste.get(i).toString()) > 0) left.add(liste.get(i));
				else right.add(liste.get(i));
			}
			if(countThreads < MAX_THREADS) right = (new QuickSortThreaded<T>(right)).sort(right);
			else right = sort(right);
			if(countThreads < MAX_THREADS) left = (new QuickSortThreaded<T>(left)).sort(left);
			else left = sort(left);
			left.add(pivot);
			left.addAll(right);
		}
		return left;
	}
}