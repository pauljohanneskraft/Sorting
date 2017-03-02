
import sorting_algorithms.*;

import java.text.*;
import java.util.*;

public class UseCase {
    // | = new round, _ = sorting successful, x = sorting unsuccessful, e = Exception/Error thrown
    private static final boolean showRoundResults = false;
    private static final boolean showCreatedArray = false;
    private static final boolean showRound = false;
    // if(round > 100) -> "+" for every 10 rounds
    private static final int rounds = 1;
    public static final int elements = 10000000;
    
    private static Sort[] algos = {
            //new BubbleSort(),
            //new InsertionSort(),
            //new SelectionSort(),
            //new HeapSort(),
            //new MergeSort(),
            //new MergeSortInPlace(),
            //new MergeSortThreaded(),
            //new AVLBinaryTreeSort(),
            //new BinaryTreeSort(),
            new QuickSortThreaded(),
            new QuickSort(),
            //new IntroSort(),
            //new IntroSortThreaded(),
            //new ShellSort()
    };

    public static String addDots(double num) {
        DecimalFormat formatter = (DecimalFormat) NumberFormat.getInstance(Locale.GERMANY);
        DecimalFormatSymbols symbols = formatter.getDecimalFormatSymbols();

        symbols.setGroupingSeparator('.');
        formatter.setDecimalFormatSymbols(symbols);

        String str = formatter.format(num);
        if(num % 1 == 0) { return str + ",0"; }
        else return str;
    }

    private static long completeTime;
    
    private static void setup() {
        completeTime = System.currentTimeMillis();
        System.out.print("sorting " + addDots(elements) + " elements using Arrays.sort()");
        for(int i = 0; i < algos.length - 1; i++) {
            System.out.print(", " + algos[i]);
        }
        if(algos.length != 0) {
            System.out.print(" and " + algos[algos.length - 1]);
        }
        System.out.println(".");
    }
    
    private static Run[][] runs = new Run[rounds][algos.length + 2];
    
    private static Number[] createArray(int j) {
        long time = System.currentTimeMillis();
        Number[] array = new Number[elements];
        for(int i = 0; i < elements; i++) {
            //array[i] = new Number(i/10);
            array[i] = new Number((int)(Math.random()*Integer.MAX_VALUE));
        }
        time = System.currentTimeMillis() - time;
        runs[j][0] = new Run(time, array, "Creation");
        return array;
    }
    
    private static String addDots(int i) {
        String str = addDots((double)i);
        return str.substring(0, str.length() - 2);
    }
    
    private static void printRound(int j) {
        if(showRound) {
            String round = addDots(j + 1) + "";
            while(round.length() < (rounds + "").length()) {
                round = " " + round;
            }
            System.out.println("Round " + round + ": " + addDots(elements) + " elements");
        } else if(rounds < 100) {
            System.out.print("|");
        } else if(j % 10 == 0) System.out.print("+");
    }
    
    private static void printCreatedArray(int j) {
        if(showRoundResults) {
            if(showCreatedArray) {
                System.out.println(runs[j][0]);
            } else {
                System.out.println("\tCreation: " + runs[j][0].time + " ms.");
            }
        }
    }
    
    private static void testJavaAlgorithm(int j, Number[] array) {
        Number[] arr = array.clone();
        long time = System.currentTimeMillis();
        Arrays.sort(arr);
        time = System.currentTimeMillis() - time;
        runs[j][1] = new Run(time, arr, "Arrays.sort()");
    }

    public static void main(String[] args) {
        setup();
        for(int j = 0; j < rounds; j++) {
            printRound(j);
            Number[] array = createArray(j);
            printCreatedArray(j);
            testJavaAlgorithm(j, array);
            //insert logic to Run.toString()
            if(showRoundResults) {
                System.out.println(runs[j][1]);
            } else if(rounds < 100) System.out.print("_");
                        
            for(int k = 0; k < algos.length; k++) {
                runs[j][k + 2] = test(algos[k], array.clone());
            }
            if(showRoundResults) System.out.println();
        }
        if(!showRound && rounds < 100) {
            System.out.print("|");
        }
        System.out.println("\n");
        showStats();
    }
    
    private static void showStats() {
        
        // ~ (name: String, time: Double) in Swift, saves average running time and name of each algorithm tested
        AverageRun[] averageRuns = new AverageRun[runs[0].length];
        
        // where the average duration of one run per algorithm is stored
        double[] durations = new double[runs[0].length];
        
        // seeting up with 0s
        for(int i = 0; i < runs[0].length; i++) {
            durations[i] = 0;
        }
        
        // adding all times up
        for(int i = 0; i < runs.length; i++) {
            for(int j = 0; j < runs[i].length; j++) {
                durations[j] += runs[i][j].time;
            }
        }
        
        // creating the an array of combinations of names and average times
        for(int i = 0; i < runs[0].length; i++) {
            averageRuns[i] = new AverageRun((durations[i]/runs.length), runs[0][i].name);
        }
        
        // sorting by average time running
        Arrays.sort(averageRuns);
        
        // printing all
        for(int i = 0; i < averageRuns.length; i++) {
            System.out.println(averageRuns[i]);
        }
        
        // printing the time in total and per run
        completeTime = System.currentTimeMillis() - completeTime;
        System.out.println("\ndone. " + addDots(completeTime) + " ms in total, " + addDots((double)(completeTime/rounds)) + " ms/round.");
    }
    
    private static Run test(Sort algo, Number[] array) {
        long time = System.currentTimeMillis();
        try { algo.sort(array); } catch (Throwable e) {
            time = System.currentTimeMillis() - time;
            Run r = new Run(time, algo.getArray(), algo.toString());
            if(showRoundResults) {
                System.out.println(r + ", Throwable: " + e.getClass().getName());
            } else {
                System.out.print("e");
            }
            return r;
        }
        try { algo.join(); } catch (Exception e) {}
        time = System.currentTimeMillis() - time;
        Run r = new Run(time, algo.getArray(), algo.toString());
        if(showRoundResults) System.out.println(r);
        else {
            if(!r.isSorted()) System.out.print("x");
            else if(rounds < 100) System.out.print("_");
        }
        return r;
    }
}















