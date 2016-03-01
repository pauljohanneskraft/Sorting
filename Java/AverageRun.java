/**
 * Created by pauljohanneskraft on 28.02.16.
 */
public class AverageRun implements Comparable {
    public AverageRun(double time, String name) {
        time = (long)(10*time);
        this.time = (time)/10;
        this.name = name;
    }
    public double time;
    public String name;
    public int compareTo(Object other) {
        if(other instanceof AverageRun) {
            double t = ((AverageRun)other).time;
            if(t > time) return -1;
            if(t < time) return 1;
        }
        return 0;
    }
    public String toString() {
        int namelength = 30;
        String name = this.name + " ";
        while(name.length() < namelength) {
            name = name + "_";
        }
        int timelength = (Long.MAX_VALUE + "").length();
        String time = " " + this.time;
        while(time.length() < timelength) {
            time = "_" + time;
        }
        time = time + " ms.";
        return name + time;
    }
}
