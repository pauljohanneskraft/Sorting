package sorting_algorithms;

public abstract class Sort<T extends Comparable> extends Thread {
    protected Sort(T[] array) {
        this(array, 0, array.length - 1);
    }
    protected Sort(T[] array, int left, int right) {
        this.array = array;
        this.length = array.length;
        this.left = left;
        this.right = right;
    }
    
    protected T[] array;
    protected int length;
    protected int left;
    protected int right;
    
    public void setArray(T[] array) {
        this.array = array;
        this.length = array.length;
        this.left = 0;
        this.right = array.length - 1;
    }
    
    public T[] getArray() { return array; }
    
    protected final void swap(int i, int j) {
        T tmp = array[i];
        array[i] = array[j];
        array[j] = tmp;
    }
}
