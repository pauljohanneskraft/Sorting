package sorting_algorithms;

/**
 * Created by pauljohanneskraft on 28.02.16.
 */
public class QuickSort<T extends Comparable> extends Sort<T> {

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
            int right = this.right;
            this.right = pivot - 1;
            run();
            this.left = pivot + 1;
            this.right = right;
            run();
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

    public String toString() { return "QuickSort"; }
}
