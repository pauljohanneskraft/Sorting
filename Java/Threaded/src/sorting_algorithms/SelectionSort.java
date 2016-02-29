package sorting_algorithms;

public class SelectionSort<T extends Comparable> extends Sort<T> {
    public SelectionSort(T[] array) {
        super(array);
    }
    SelectionSort(T[] array, int left, int right) { super(array, left, right); }
    
    public void run() {
        for(int i = left; i <= right; i++) {
            int min = i;
            for(int j = i + 1; j <= right; j++) {
                if(array[min].compareTo(array[j]) > 0) {
                    min = j;
                }
            }
            swap(min, i);
        }
    }
    
    public String toString() { return "SelectionSort"; }
}
