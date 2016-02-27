
/**
 * Write a description of class Number here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Number implements Comparable {
    Number(int number) {
        this.value = number;
    }
    
    private final int value;
    
    public int getValue() {
        return value;
    }
    
    public int compareTo(Object other) {
        if(other instanceof Number) {
            return this.getValue() - ((Number)other).getValue();
        }
        return Integer.MAX_VALUE;
    }
    
    public String toString() {
        String out = value + "";
        while(out.length() < (Integer.MAX_VALUE + "").length()) {
            out = "0" + out;
        }
        return out;
    }
}
