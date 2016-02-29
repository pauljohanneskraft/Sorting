package sorting_algorithms;

public class ShellSort<T extends Comparable> extends Sort<T> {
    public ShellSort(T[] array) { super(array); }
    ShellSort(T[] array, int left, int right) { super(array, left, right); }

    private static final int[] columns = {8388607, 4194303, 2097151, 1048575, 524287, 262143,
            131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1};

    public void run() {
        int s = 0;
        while(columns[s] > (right-left)) { s++; }

        for(int k = s; k < columns.length; k++) {
            int h = columns[k] + left;

            for(int i = h; i <= right; i++) {
                T t = array[i];
                int j = i;

                // t < array[j-h]
                while (j >= h && t.compareTo(array[j - h]) < 0) {
                    array[j] = array[j - h];
                    j -= h;
                }
                array[j] = t;
            }
        }
    }
    
    public String toString() { return "ShellSort"; }
}
