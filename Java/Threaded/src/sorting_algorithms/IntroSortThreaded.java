package sorting_algorithms;

/**
 * Created by pauljohanneskraft on 28.02.16.
 */
public class IntroSortThreaded<T extends Comparable> extends Sort<T> {

    public IntroSortThreaded(T[] array) {
        super(array);
        this.depth = 2*(int)(Math.log(array.length));
    }

    IntroSortThreaded(T[] array, int left, int right, int depth) {
        super(array, left, right);
        this.depth = depth;
    }

    public void setArray(T[] array) {
        super.setArray(array);
        this.depth = 2*(int)(Math.log(array.length));
    }

    private int depth = 400;
    private static int count = 0;

    public void run() {
        if(left >= right) { return; }
        else if(right - left < 20) {
            Sort sort = (new SelectionSort(array, left, right));
            sort.start();
            try { sort.join(); } catch(Exception e) {
                System.out.println("Exception, join()");
            }
        }
        else if(depth <= 0) {
            Sort sort = (new BinaryTreeSort(array, left, right));
            sort.start();
            try { sort.join(); } catch(Exception e) {
                System.out.println("Exception, join()");
            }
        }
        else {
            int pivot = partition();
            if(count < 20) {
                Sort leftsort = (new IntroSortThreaded(array, left, pivot - 1, depth - 1));
                leftsort.start();
                Sort rightsort = (new IntroSortThreaded(array, pivot + 1, right, depth - 1));
                rightsort.start();
                try {
                    leftsort.join();
                    rightsort.join();
                } catch(Exception e) {}
            }
            else {
                depth--;
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

    public String toString() {
        return "IntroSortThreaded";
    }
}
