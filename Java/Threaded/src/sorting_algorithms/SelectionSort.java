package sorting_algorithms;

public class SelectionSort<T extends Comparable> extends Sort<T> {
    public SelectionSort(T[] array) {
        super(array);
    }
    
    public void run() {
        for(int i = 0; i < length; i++) {
            int min = i;
            for(int j = i + 1; j < length; j++) {
                if(array[min].compareTo(array[j]) > 0) {
                    min = j;
                }
            }
            swap(min, i);
        }
    }
    
    public String toString() { return "SelectionSort"; }
}
