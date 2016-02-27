package sorting_algorithms;

public abstract class Sort<T extends Comparable> extends Thread {
    protected Sort(T[] array) {  setArray(array); }
    
    protected T[] array;
    protected int length;
    
    public void setArray(T[] array) { 
        this.array = array;
        this.length = array.length;
    }
    
    public T[] getArray() { return array; }
    
    protected final void swap(int i, int j) {
        T tmp = array[i];
        array[i] = array[j];
        array[j] = tmp;
    }
}
