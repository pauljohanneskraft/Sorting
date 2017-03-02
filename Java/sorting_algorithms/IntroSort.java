package sorting_algorithms;

import javax.swing.tree.*;

public class IntroSort<T extends Comparable> extends QuickSort<T> {
    public IntroSort() {}
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

    protected int depth = 0;

    public void run() {
        if(left >= right) { return; }
        if(right - left < 20) {
            Sort sort = new InsertionSort<>(array, left, right);
            sort.start();
            try{ sort.join(); } catch(Throwable e) {}
            return;
        }
        if(depth <= 0) {
            Sort sort = new AVLBinaryTreeSort<>(array, left, right);
            sort.start();
            try{ sort.join(); } catch(Throwable e) {}
            return;
        }
        depth--;
        int pivot = partition();
        int right = this.right;
        this.right = pivot - 1;
        run();
        this.left = pivot + 1;
        this.right = right;
        run();
    }

    public String toString() {
        return "IntroSort";
    }
}
