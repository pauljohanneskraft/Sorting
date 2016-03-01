package sorting_algorithms;

public class QuickSort<T extends Comparable> extends Sort<T> {
    public QuickSort() {}
    public QuickSort(T[] array) {
        this(array, 0, array.length - 1);
    }
    protected QuickSort(T[] array, int left, int right) {
        super(array);
        this.left = left;
        this.right = right;
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

    protected int partition() {
        int i = left;
        int j = right - 1;
        T p = array[right];
        do {
            while(p.compareTo(array[i]) >= 0 && i < right) { i++; }
            while(p.compareTo(array[j]) <= 0 && j > left) { j--; }
            if(i < j) { swap(i,j); }
        } while(i < j);
        if(p.compareTo(array[i]) < 0) { swap(i, right); }
        return i;
    }

    public String toString() { return "QuickSort"; }
}
