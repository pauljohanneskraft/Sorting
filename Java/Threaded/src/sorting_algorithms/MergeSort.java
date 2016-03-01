package sorting_algorithms;

import java.util.ArrayList;
import java.util.Arrays;

public class MergeSort<T extends Comparable> extends Sort<T> {
    public MergeSort() {}
    MergeSort(ArrayList<T> array) { this.array = array; }

    public void setArray(T[] array) {
        super.setArray(array);
        this.array = new ArrayList<T>(Arrays.asList(super.array));
    }

    protected ArrayList<T> array;

    protected ArrayList<T> getArrayList() {
        return array;
    }

    public T[] getArray() {
        super.array = array.toArray(super.array);
        return super.getArray();
    }

    public void run() {
        array = mergeSort(array);
    }

    protected ArrayList<T> mergeSort(ArrayList<T> array) {
        if(array.size() < 2) { return array; }
        ArrayList<T> list = (ArrayList<T>)array.clone();
        ArrayList<T> leftarray = new ArrayList<>(list.subList(0, list.size()/2));
        ArrayList<T> rightarray = new ArrayList<>(list.subList(list.size()/2, list.size()));
        leftarray = mergeSort(leftarray);
        rightarray = mergeSort(rightarray);
        return merge(leftarray, rightarray);
    }

    // in-place merging
    protected ArrayList<T> merge(ArrayList<T> left, ArrayList<T> right) {
        ArrayList<T> res = new ArrayList<>();
        while(left.size() > 0 && right.size() > 0) {
            if(left.get(0).compareTo(right.get(0)) < 0) {
                res.add(left.remove(0));
            } else {
                res.add(right.remove(0));
            }
        }
        while(left.size() > 0) { res.add(left.remove(0)); }
        while(right.size() > 0) { res.add(right.remove(0)); }
        //System.out.println();
        return res;
    }

    public String toString() {
        return "MergeSort";
    }
}
