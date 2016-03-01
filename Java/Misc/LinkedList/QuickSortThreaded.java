package LinkedList;
import java.util.*;

class QuickSortThreaded<T> extends Sort<T> {
	private LinkedList<T> liste;
	public QuickSortThreaded(LinkedList<T> liste)
	{
		this.liste = liste;
	}
	
	public void run()
	{
		sort(liste);
	}
	
	<T> void sort(LinkedList<T> liste) {
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
			if(right.size() > 20) new QuickSortThreaded<T>(right).start();
			else sort(right);
			if(left.size() > 20) new QuickSortThreaded<T>(left).start();
			else sort(left);
			left.add(pivot);
			left.addAll(right);
			liste = left;
		}
	}
}