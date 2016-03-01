
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
    private static final boolean printAllElements = true;
    
    Run(long time, T[] array, String name) {
        this.time = time;
        this.array = array;
        this.name = name;
    }
    
    public String toString() {
        String out = "\t" + name + ": ";
        while(out.length() < 30) {
            out = out + " ";
        }
        String t = UseCase.addDots(time) + "";
        while(t.length() < (""+Long.MAX_VALUE).length()) {
            t = " " + t;
        }
        out = out + t + " ms, " + array.length + " elements, ";
        out += "sorted: " + (isSorted() ? "Yes" : "No");
        if(printAllElements) {
            if (!isSorted()) {
                out += "\n";
                for(int i = 0; i < array.length; i++) {
                    out += array[i] + ", ";
                }
                out = out.substring(0, out.length() - 2);
            }
        }
        return out;
    }
    
    boolean isSorted() {
        for (int i = 0; i < (array.length < 100 ? (array.length - 1) : 100); i += 2) {
            if (array[i].compareTo(array[i+1]) > 0) {
                return false;
            }
        }
        return true;
    }
}
