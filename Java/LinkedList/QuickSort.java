
package SortingAlgs;
import java.util.*;

class QuickSort<T> extends Sort<T> {
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
			right = sort(right);
			left = sort(left);
			left.add(pivot);
			left.addAll(right);
		}
		return left;
	}
}