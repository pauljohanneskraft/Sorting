
import sorting_algorithms.*;
import java.util.*;

public class UseCase {
    private static final boolean showRoundResults = false;
    private static final boolean showCreatedArray = false;
    private static final boolean showRound = false;
    private static final int rounds = 2;
    private static final int elements = 1000000;
    private static Number[] a = {};
    private static Sort[] algos = {
            //new BubbleSort(a),
            //new InsertionSort(a),
            //new SelectionSort(a),
            new BinaryTreeSort(a),
            //new QuickSortThreaded(a),
            new QuickSort(a),
            new IntroSort(a),
            //new IntroSortThreaded(a),
            new ShellSort(a)
    };
    
    public static void main(String[] args) {
        Run[][] runs = new Run[rounds][algos.length + 2];
        for(int j = 0; j < rounds; j++) {
            if(showRound) {
                String round = j + 1 + "";
                while(round.length() < (rounds + "").length()) {
                    round = " " + round;
                }
                System.out.println("Round " + round + ": " + elements + " elements");
            } else System.out.print(".");
            long time = System.currentTimeMillis();
            Number[] array = new Number[elements];
            for(int i = 0; i < elements; i++) {
                array[i] = new Number((int)(Math.random()*Integer.MAX_VALUE));
            }
            time = System.currentTimeMillis() - time;
            runs[j][0] = new Run(time, array, "Creation");
            if(showRoundResults) {
                if(showCreatedArray) {
                    System.out.println(runs[j][0]);
                } else {
                    System.out.println("\tCreation: " + time + " ms.");
                }
            }
            Number[] arr = array.clone();
            time = System.currentTimeMillis();
            Arrays.sort(arr);
            time = System.currentTimeMillis() - time;
            runs[j][1] = new Run(time, arr, "java.util.Arrays.sort()");
            if(showRoundResults) {
                System.out.println(runs[j][1]);
            } else System.out.print("_");
            for(int k = 0; k < algos.length; k++) {
                algos[k].setArray(array.clone());
                runs[j][k + 2] = test(algos[k]);
            }
            if(showRoundResults) System.out.println();
        }
        System.out.println("\n");
        AverageRun[] averageRuns = new AverageRun[runs[0].length];
        double[] durations = new double[runs[0].length];
        for(int i = 0; i < runs[0].length; i++) {
            durations[i] = 0;
        }
        for(int i = 0; i < runs.length; i++) {
            for(int j = 0; j < runs[i].length; j++) {
                durations[j] += runs[i][j].time;
            }
        }
        for(int i = 0; i < runs[0].length; i++) {
            averageRuns[i] = new AverageRun((durations[i]/runs.length), runs[0][i].name);
        }
        Arrays.sort(averageRuns);
        for(int i = 0; i < averageRuns.length; i++) {
            System.out.println(averageRuns[i]);
        }
    }
    
    private static Run test(Sort algo) {
        long time = System.currentTimeMillis();
        algo.run();
        try { algo.join(); } catch (Exception e) {}
        time = System.currentTimeMillis() - time;
        Run r = new Run(time, algo.getArray(), algo.toString());
        if(showRoundResults) System.out.println(r);
        else {
            if(!r.isSorted()) System.out.print("x");
            else System.out.print("_");
        }
        return r;
    }
}















