package sorting_algorithms;

/**
 * Write a description of class QuickSort here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class QuickSort<T extends Comparable> extends Sort<T> {
    private int left;
    private int right;
    private static final int LIMIT = 20;
    
    public QuickSort(T[] array) {
        this(array, 0, array.length - 1);
    }
    
    private QuickSort(T[] array, int left, int right) {
        super(array);
        this.left = left;
        this.right = right;
    }

    public void setArray(T[] array) {
        super.setArray(array);
        this.left = 0;
        this.right = length - 1;
    }
    
    public void run() {
        if(left < right) {
            int pivot = partition();
            Sort leftsort = (new QuickSort(array, left, pivot - 1));
            if(pivot - left > LIMIT) { leftsort.start(); }
            else { leftsort.run(); }
            Sort rightsort = (new QuickSort(array, pivot + 1, right));
            if(right - pivot > LIMIT) { rightsort.start(); }
            else { rightsort.run(); }
            try {
                leftsort.join();
                rightsort.join();
            } catch(Exception e) {}
        }
    }
    
    private synchronized int partition() {
        int i = left;
        int j = right - 1;
        T p = array[right];
        do {
            while(array[i].compareTo(p) <= 0 && i < right) { i++; }
            while(array[j].compareTo(p) >= 0 && j > left) { j--; }
            if(i < j) { swap(i,j); }
        } while(i < j);
        if(array[i].compareTo(p) > 0) { swap(i, right); }
        return i;
    }
    
    public String toString() { return "QuickSort"; }
}
