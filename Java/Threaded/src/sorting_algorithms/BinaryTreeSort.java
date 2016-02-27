package sorting_algorithms;

import java.util.*;
/**
 * building a binary tree and printing out in order.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
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
    
    private Knot root;
    
    public void run() {
        saveArray(array);
        T[] arr = (T[])(root.getArray().toArray());
    }
    
    private void saveArray(T[] array) {
        if(root == null) root = new Knot(array[0]);
        else root.insert(array[0]);
        for(int i = 1; i < length; i++) {
            root.insert(array[i]);
        }
    }
    
    public String toString() { return "BinaryTreeSort"; }
}
