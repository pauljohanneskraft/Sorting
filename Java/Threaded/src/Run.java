
/**
 * Write a description of class Run here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Run<T extends Comparable> {
    public long time;
    public T[] array;
    public String name;
    
    Run(long time, T[] array, String name) {
        this.time = time;
        this.array = array;
        this.name = name;
    }
    
    public String toString() {
        String out = name + ":\t" + time + "\tms.";
        if(!isSorted()) {
            out += "\n";
            for(int i = 0; i < array.length; i++) {
                out += array[i] + ", ";
            }
        }
        return out;
    }
    
    private boolean isSorted() {
        for (int i = 0; i < array.length - 1; i++) {
            if (array[i].compareTo(array[i+1]) > 0) {
                return false;
            }
        }
        return true;
    }
}
