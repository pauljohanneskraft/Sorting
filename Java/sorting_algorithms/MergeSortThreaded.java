package sorting_algorithms;

import java.util.ArrayList;
import java.util.Arrays;

public class MergeSortThreaded<T extends Comparable> extends MergeSort<T> {
    public MergeSortThreaded() {}
    private MergeSortThreaded(ArrayList<T> array) { super(array); }

    private static int maxThreads = 10;

    protected ArrayList<T> mergeSort(ArrayList<T> array) {
        if(array.size() < 2) { return array; }
        MergeSort leftsort;
        MergeSort rightsort;
        ArrayList<T> list = (ArrayList<T>)array.clone();
        ArrayList<T> leftarray = new ArrayList<>(list.subList(0, list.size()/2));
        ArrayList<T> rightarray = new ArrayList<>(list.subList(list.size()/2, list.size()));
        int threadCount = 0;
        if(leftarray.size() > 50 && maxThreads > 0) {
            maxThreads--;
            leftsort = new MergeSortThreaded<>(leftarray);
            threadCount++;
        } else {
            leftsort = new MergeSort<>(leftarray);
        }
        if(rightarray.size() > 50 && maxThreads > 0) {
            maxThreads--;
            rightsort = new MergeSortThreaded<>(rightarray);
            threadCount++;
        } else {
            rightsort = new MergeSort<>(rightarray);
        }
        leftsort.start();
        rightsort.start();
        try {
            leftsort.join();
            rightsort.join();
        } catch(Exception e) {}
        maxThreads -= threadCount;
        return merge(leftsort.getArrayList(), rightsort.getArrayList());
    }

    public String toString() {
        return "MergeSortThreaded";
    }
}
