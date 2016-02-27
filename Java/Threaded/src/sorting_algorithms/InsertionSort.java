package sorting_algorithms;

public class InsertionSort<T extends Comparable> extends Sort<T> {
    public InsertionSort(T[] array) { super(array); }
    
    public void run() {
        for(int i = 1; i < length; i++) {
            T pivot = array[i];
            int k = i;
            while(k > 0 && pivot.compareTo(array[k - 1]) < 0) {
                array[k] = array[k-1];
                k--;
            }
            array[k] = pivot;
        }
    }
    
    public String toString() { return "InsertionSort"; }
}
