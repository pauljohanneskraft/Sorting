package sorting_algorithms;

public class BubbleSort<T extends Comparable> extends Sort<T> {
    public BubbleSort(T[] array) {
        super(array);
    }
    
    public void run() {
        boolean didChange;
        do {
            didChange = false;
            for(int i = 0; i < length - 1; i++) {
                if(array[i].compareTo(array[i+1]) > 0) {
                    swap(i, i+1);
                    didChange = true;
                }
            }
        } while(didChange);
    }
    
    public String toString() { return "BubbleSort"; }
}
