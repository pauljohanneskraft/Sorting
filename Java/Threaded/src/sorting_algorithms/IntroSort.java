package sorting_algorithms;

/**
 * Write a description of class IntroSort here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class IntroSort<T extends Comparable> extends Sort<T> {
    
    public IntroSort(T[] array) {
        super(array);
        this.depth = 2*(int)(Math.log(array.length));
    }

    IntroSort(T[] array, int left, int right, int depth) {
        super(array, left, right);
        this.depth = depth;
    }

    public void setArray(T[] array) {
        super.setArray(array);
        this.depth = 2*(int)(Math.log(array.length));
    }

    private int depth = 400;

    public void run() {
        if(left >= right) { return; }
        else if(right - left < 20) {
            Sort sort = (new SelectionSort(array, left, right));
            sort.run();
        }
        else if(depth <= 0) {
            Sort sort = (new BinaryTreeSort(array, left, right));
            sort.run();
        }
        else {
            depth--;
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

    public String toString() {
        return "IntroSort";
    }
}
