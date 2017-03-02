package sorting_algorithms;

public class QuickSortThreaded<T extends Comparable> extends QuickSort<T> {
    private static final int LIMIT = 50;

    public QuickSortThreaded() {}

    public QuickSortThreaded(T[] array) {
        this(array, 0, array.length - 1);
    }

    private static int maxThreads = Runtime.getRuntime().availableProcessors();
    
    private QuickSortThreaded(T[] array, int left, int right) {
        super(array);
        this.left = left;
        this.right = right;
    }

    public void setArray(T[] array) {
        maxThreads = Runtime.getRuntime().availableProcessors();
        super.setArray(array);
        this.left = 0;
        this.right = length - 1;
    }
    
    public void run() {
        if(left < right) {
            int pivot = partition();
            QuickSort leftsort;
            QuickSort rightsort;
            int threadCount = 0;
            if(right - pivot > LIMIT && maxThreads > 0) {
                maxThreads--;
                leftsort = (new QuickSortThreaded<>(array, left, pivot - 1));
                threadCount++;
            } else {
                leftsort = new QuickSort<>(array, left, pivot - 1);
            }
            if(pivot - left > LIMIT && maxThreads > 0) {
                maxThreads--;
                rightsort = (new QuickSortThreaded<>(array, pivot + 1, right));
                threadCount++;
            } else {
                rightsort = new QuickSort<>(array, pivot + 1, right);
            }
            try {
                leftsort.start();
                rightsort.start();
            } catch(Throwable e) {throw e;}
            try {
                leftsort.join();
                rightsort.join();
            } catch(Throwable e) {}
            maxThreads += threadCount;
        }
    }

    public String toString() { return "QuickSortThreaded"; }
}
