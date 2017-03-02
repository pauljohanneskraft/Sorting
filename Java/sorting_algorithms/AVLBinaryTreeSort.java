package sorting_algorithms;

import java.util.ArrayList;

public class AVLBinaryTreeSort<T extends Comparable> extends Sort<T> {

    public AVLBinaryTreeSort() {}

    private class Knot {
        Knot left = null;
        Knot right = null;
        int balance = -1;
        T info;
        Knot(T info) { this.info = info; }
        Knot insert(T info) {
            double cmp = this.info.compareTo(info);
            if(cmp > 0) {
                if(left == null) left = new Knot(info);
                else left = left.insert(info);
            }
            else {
                if(right == null) right = new Knot(info);
                else right = right.insert(info);
            }
            return balance();
        }

        private int updateBalance() {
            int lb = -1, rb = -1;
            if(left != null) { lb = left.balance; }
            if(right != null) { rb = right.balance; }
            balance = Math.max(lb,rb) + 1;
            return lb - rb;
        }

        Knot balance() {
            int b = updateBalance();
            // only rotating in "extreme" cases -> faster
            if(b > 10) {
                //System.out.println("rotate right");
                Knot tmp = left;
                left = left.right;
                tmp.right = this;
                return tmp;
            } else if(b < -10) {
                //System.out.println("rotate left");
                Knot tmp = right;
                right = right.left;
                tmp.left = this;
                return tmp;
            }
            return this;
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

    public AVLBinaryTreeSort(T[] array) { super(array); }
    AVLBinaryTreeSort(T[] array, int left, int right) { super(array, left, right); }
    
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
            root = root.insert(array[i]);
            //System.out.println("did insert " + array[i] + " - " + i);
        }
    }
    
    public String toString() { return "AVLBinaryTreeSort"; }
}
