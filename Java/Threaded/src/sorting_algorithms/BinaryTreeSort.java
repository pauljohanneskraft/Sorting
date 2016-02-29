package sorting_algorithms;

import java.util.*;

public class BinaryTreeSort<T extends Comparable> extends Sort<T> {

    private class Knot {
        Knot left = null;
        Knot right = null;
        T info;
        Knot(T info) { this.info = info; }
        void insert(T info) {
            double cmp = this.info.compareTo(info);
            if(cmp > 0) {
                if(left == null) left = new Knot(info);
                else left.insert(info);
            }
            else {
                if(right == null) right = new Knot(info);
                else right.insert(info);
            }
        }
        ArrayList<T> getArray() {
            ArrayList<T> list = new ArrayList<T>();
            if(left != null) { list.addAll(left.getArray()); }
            list.add(info);
            if(right != null) { list.addAll(right.getArray()); }
            return list;
        }
    }
    
    public BinaryTreeSort(T[] array) { super(array); }
    BinaryTreeSort(T[] array, int left, int right) { super(array, left, right); }
    
    private Knot root;
    
    public void run() {
        saveArray();
        retrieveArray();
        root = null;
    }

    private void retrieveArray() {
        ArrayList<T> sorted = root.getArray();
        int range = right - left;
        if(range == length - 1) {
            array = sorted.toArray(array);
        } else {
            for(int i = 0; i <= range; i++) {
                array[left + i] = sorted.get(i);
            }
        }
    }
    
    private void saveArray() {
        if(root == null) root = new Knot(array[left]);
        else root.insert(array[left]);
        for(int i = left + 1; i <= right; i++) {
            root.insert(array[i]);
        }
    }
    
    public String toString() { return "BinaryTreeSort"; }
}
