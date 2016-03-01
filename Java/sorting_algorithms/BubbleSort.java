package sorting_algorithms;

public class BubbleSort<T extends Comparable> extends Sort<T> {
    public BubbleSort() {}
    public BubbleSort(T[] array) {
        super(array);
    }
    BubbleSort(T[] array, int left, int right) { super(array, left, right); }
    
    public void run() {
        boolean didChange;
        do {
            didChange = false;
            for(int i = left; i < right; i++) {
                if(array[i].compareTo(array[i+1]) > 0) {
                    swap(i, i+1);
                    didChange = true;
                }
            }
        } while(didChange);
    }
    
    public String toString() { return "BubbleSort"; }
}
