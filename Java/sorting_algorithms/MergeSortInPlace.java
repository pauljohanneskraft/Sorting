package sorting_algorithms;

import java.util.ArrayList;
import java.util.Arrays;

public class MergeSortInPlace<T extends Comparable> extends Sort<T> {
    public MergeSortInPlace() {}

    private ArrayList<T> array;

    public void run() {
        this.array = new ArrayList<T>(Arrays.asList(super.array));
        recursive(left, right);
        super.array = array.toArray(super.array);
    }

    private void recursive(int left, int right) {
        if(right - left < 1) { return; }
        int mid = (left + right + 1) / 2;
        recursive(left, mid - 1);
        recursive(mid, right);
        merge(left, right, mid);
    }

    // in-place merging
    private void merge(int left, int right, int mid) {
        for(int l = left; l <= right; l++) {
            if(l >= mid) { return; }
            if(array.get(l).compareTo(array.get(mid)) > 0) {
                array.add(l, array.remove(mid));
                mid++;
            }
            if(right < mid) { return; }
        }
    }

    public String toString() {
        return "MergeSortInPlace";
    }
}
