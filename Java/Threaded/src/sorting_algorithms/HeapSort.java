package sorting_algorithms;

import java.util.*;

public class HeapSort<T extends Comparable> extends Sort<T> {
    public HeapSort() {}
    protected HeapSort(T[] array) { super(array); }
    protected HeapSort(T[] array, int left, int right) { super(array, left, right); }

    protected ArrayList<T> array;

    public void run() {
        array = new ArrayList<T>(Arrays.asList(super.array));
        if(length < 2) { return; }
        buildMaxHeap();
        ArrayList<T> sorted = new ArrayList<T>();
        while(array.size() > 1) {
            sorted.add(0, array.get(0));
            swap(0, array.size() - 1);
            array.remove(array.size() - 1);
            maxHeapify(0);
        }
        sorted.add(0, array.get(0));
        super.array = sorted.toArray(super.array);
    }

    private int leftLeaf(int root)  {
        return ( root + 1 ) * 2 - 1;
    }

    private int rightLeaf(int root) {
        return ( root + 1 ) * 2;
    }

    private void maxHeapify(int rootIndex){
        if(leftLeaf(rootIndex) > array.size() - 1) { return; }
        T rootValue = array.get(rootIndex);
        int largestIndex = rootIndex;
        T largestValue = rootValue;
        if(array.get(leftLeaf(rootIndex)).compareTo(largestValue) > 0) {
            largestValue = array.get(leftLeaf(rootIndex));
            largestIndex = leftLeaf(rootIndex);
        }
        if(rightLeaf(rootIndex) <= array.size() - 1) {
            if(array.get(rightLeaf(rootIndex)).compareTo(largestValue) > 0) {
                largestValue = array.get(rightLeaf(rootIndex));
                largestIndex = rightLeaf(rootIndex);
            }
        }
        if(largestIndex != rootIndex) {
            swap(rootIndex, largestIndex);
            maxHeapify(largestIndex);
        }
    }

    private void buildMaxHeap() {
        if(length < 2) { return; }
        int mid = length/2;
        while(mid >= 0) {
            maxHeapify(mid);
            mid--;
        }
    }

    public String toString() {
        return "HeapSort";
    }
}
