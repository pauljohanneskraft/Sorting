package sorting_algorithms;


public class IntroSortThreaded<T extends Comparable> extends IntroSort<T> {
    public IntroSortThreaded() {}
    public IntroSortThreaded(T[] array) {
        super(array);
        depth = 2*(int)(Math.log(array.length));
    }

    IntroSortThreaded(T[] array, int left, int right, int depth) {
        super(array, left, right, depth);
    }

    public void setArray(T[] array) {
        super.setArray(array);
        depth = 2*(int)(Math.log(array.length));
    }

    private static int maxThreads = 20;

    public void run() {
        if(left >= right) { return; }
        if(right - left < 20) {
            Sort sort = (new SelectionSort(array, left, right));
            sort.start();
            try { sort.join(); } catch(Exception e) {
                System.out.println("Exception, join()");
            }
            return;
        }
        if(depth <= 0) {
            Sort sort = (new BinaryTreeSort(array, left, right));
            sort.start();
            try { sort.join(); } catch(Exception e) {
                System.out.println("Exception, join()");
            }
            return;
        }
        int pivot = partition();
        IntroSort leftsort;
        IntroSort rightsort;
        int threadCount = 0;
        if(pivot - left > 50 && maxThreads > 0) {
            maxThreads--;
            leftsort = new IntroSortThreaded<>(array, left, pivot - 1, depth - 1);
            threadCount++;
        } else {
            leftsort = new IntroSort<>(array, left, pivot - 1, depth - 1);
        }
        if(right - pivot > 50 && maxThreads > 0) {
            maxThreads--;
            rightsort = new IntroSortThreaded<>(array, pivot + 1, right, depth - 1);
            threadCount++;
        } else {
            rightsort = new IntroSort<>(array, pivot + 1, right, depth - 1);
        }
        rightsort.start();
        leftsort.start();
        try {
            leftsort.join();
            rightsort.join();
        } catch(Exception e) {}
        maxThreads += threadCount;
    }

    public String toString() {
        return "IntroSortThreaded";
    }
}
