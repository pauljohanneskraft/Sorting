
package sorting_algorithms;

public class InsertionSort<T extends Comparable> extends Sort<T> {
    public InsertionSort() {}
    public InsertionSort(T[] array) { super(array); }
    InsertionSort(T[] array, int left, int right) { super(array, left, right); }
    
    public void run() {
        for(int i = left + 1; i <= right; i++) {
            T pivot = array[i];
            int k = i;
            while(k > left && pivot.compareTo(array[k - 1]) < 0) {
                array[k] = array[k-1];
                k--;
            }
            array[k] = pivot;
        }
    }
    
    public String toString() { return "InsertionSort"; }
}
