package sorting_algorithms;

/**
 * Write a description of class QuickSort here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class QuickSortThreaded<T extends Comparable> extends Sort<T> {
    private static final int LIMIT = 20;
    
    public QuickSortThreaded(T[] array) {
        this(array, 0, array.length - 1);
    }
    
    private QuickSortThreaded(T[] array, int left, int right) {
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
            if(pivot - left > LIMIT && right - pivot > LIMIT) {
                Sort leftsort = (new QuickSortThreaded(array, left, pivot - 1));
                leftsort.start();
                Sort rightsort = (new QuickSortThreaded(array, pivot + 1, right));
                rightsort.start();
                try {
                    leftsort.join();
                    rightsort.join();
                } catch(Exception e) {}
            }
            else {
                int right = this.right;
                this.right = pivot - 1;
                run();
                this.left = pivot + 1;
                this.right = right;
                run();
            }
        }
    }
    
    private int partition() {
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

    public String toString() { return "QuickSortThreaded"; }
}
