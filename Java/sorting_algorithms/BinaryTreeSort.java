package sorting_algorithms;

import java.util.*;

// could throw a StackOverflowError, when inserting values, when array is already sorted.
public class BinaryTreeSort<T extends Comparable> extends Sort<T> {

    public BinaryTreeSort() {}

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

        public String toString() {
            String str = "";
            if(left != null) str += left.toString();
            str += info.toString() + ", ";
            if(right != null) str += right.toString();
            return str;
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
        binaryInsertion(left + 1, right);
    }

    private void binaryInsertion(int left, int right) {
        if(right < left) { return; }
        int mid = (left + right) / 2;
        root.insert(array[mid]);
        binaryInsertion(left, mid - 1);
        binaryInsertion(mid + 1, right);
    }
    
    public String toString() { return "BinaryTreeSort"; }
}
